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
        flash.now[:notice] = 'Item correctly added to your trip'
      else
        flash.now[:alert] = 'You have already added this item'
      end
    end

  def destroy
    # To be filled
  end

  def update
    @trip_item = TripItem.find(params[:id])
    authorize @trip_item
    if @trip_item.update(trip_item_params)
      flash.now[:notice] = 'Item updated'
    else
      flash.now[:alert] = 'Could not update this item. Sorry!'
    end
  end

  private

  def trip_item_params
    params.require(:trip_item).permit(:date, :name, :country, :city)
  end
end
