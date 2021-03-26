class PrizesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_prize, only: [:show, :edit, :update, :destroy, :draw, :remove_record]

  # GET /prizes
  # GET /prizes.json
  def index
    @prizes = Prize.all.drawable.order(id: :asc)
  end

  # GET /prizes/1
  # GET /prizes/1.json
  def show
    @users = @prize.users
  end

  # GET /prizes/new
  def new
    @prize = Prize.new
  end

  # GET /prizes/1/edit
  def edit
  end

  # POST /prizes
  # POST /prizes.json
  def create
    @prize = Prize.new(prize_params)

    respond_to do |format|
      if @prize.save
        format.html { redirect_to @prize, notice: 'Prize was successfully created.' }
        format.json { render :show, status: :created, location: @prize }
      else
        format.html { render :new }
        format.json { render json: @prize.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prizes/1
  # PATCH/PUT /prizes/1.json
  def update
    respond_to do |format|
      if @prize.update(prize_params)
        format.html { redirect_to @prize, notice: 'Prize was successfully updated.' }
        format.json { render :show, status: :ok, location: @prize }
      else
        format.html { render :edit }
        format.json { render json: @prize.errors, status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /prizes/1
  # # DELETE /prizes/1.json
  # def destroy
  #   @prize.destroy
  #   respond_to do |format|
  #     format.html { redirect_to prizes_url, notice: 'Prize was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  def draw
    limit = (params[:limit] || 1).to_i
    users = @prize.limited? ? User.active.not_win_yet.drawable : User.active.not_win_yet

    if users.blank?
      render json: { result: false, message: '目前沒有符合抽獎資格的員工' }
      return
    end
    limit = users.count if limit > users.count
    winners = users.sample(limit)
    display_name_list = users.sample(20)
    fulfilled_quantity = @prize.fulfilled_quantity + limit
    ActiveRecord::Base.transaction do
      winners.each do |winner|
        winner.update!(win: true)
        PrizeRecord.create!(user_id: winner.id, prize_id: @prize.id)
      end
      @prize.update!(fulfilled_quantity: fulfilled_quantity)
    end

    render json: { result: true, winners: winners, winner_count: fulfilled_quantity, display_name_list: display_name_list }
  rescue ex
    render json: { result: false, message: '抱歉，系統出現問題，請稍後再試'}, status: 500
  end

  def remove_record
    if params[:user_id].blank?
      render json: { result: false, message: '缺少user資訊' }
      return
    end
    fulfilled_quantity = @prize.fulfilled_quantity - 1
    ActiveRecord::Base.transaction do
      PrizeRecord.find_by(user_id: params[:user_id], prize_id: @prize.id).delete
      User.find(params[:user_id]).update!(win: false)
      @prize.update!(fulfilled_quantity: fulfilled_quantity)
    end
    render json: {result: true, winners: @prize.reload.users, winner_count: fulfilled_quantity}
  rescue => ex
    render json: { result: false, message: '抱歉，系統出現問題，請稍後再試'}, status: 500
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_prize
    @prize = Prize.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def prize_params
    params.require(:prize).permit(:title, :content, :quantity, :key, :drawable, :bulk, :limited)
  end
end
