class DrawController < ApplicationController

  def draw_index
    @prizes = Prize.drawable
  end

  def draw
    return if params[:prize_id].blank?

    @prize = Prize.find(params[:prize_id])
    
  end

  private
 
end
