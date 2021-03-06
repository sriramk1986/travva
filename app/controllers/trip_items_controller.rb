class TripItemsController < ApplicationController
  def create
    @trip_item = TripItem.new
    @trip_item.trip_id = params[:trip_id]
    @item_id = params[:item]
    @trip_item.item_id = @item_id

    if params[:date]
      @trip_item.date = Date.parse(params[:date])
    end

    authorize @trip_item
      if @trip_item.save
        @dates = (@trip_item.trip.start_date..@trip_item.trip.end_date).to_a
        if @trip_item.date
          @trip_items = @trip_item.trip.trip_items.where(date: @trip_item.date)
        else
          @trip_items = @trip_item.trip.trip_items
        end
        @markers = @trip_items.map do |trip_item|
          {
            lat: trip_item.item.latitude,
            lng: trip_item.item.longitude
          }
        end
        flash.now[:notice] = 'Item correctly added to your trip'
      else
        flash.now[:alert] = 'You have already added this item'
      end
    end

  def destroy
    @trip_item = TripItem.find(params[:id])
    @trip_item.destroy
    authorize @trip_item
    redirect_to trip_path(@trip_item.trip)
  end

  def update
    @trip_item = TripItem.find(params[:id])
    authorize @trip_item
    if @trip_item.update(trip_item_params)
      flash.now[:notice] = 'Item updated'
    else
      flash.now[:alert] = 'Could not update this item. Sorry!'
    end
    respond_to do |format|
      format.html { redirect_to trip_path(@trip_item.trip) }
      format.js
    end
  end

  private

  def trip_item_params
    params.require(:trip_item).permit(:date, :name, :country, :city)
  end
end
