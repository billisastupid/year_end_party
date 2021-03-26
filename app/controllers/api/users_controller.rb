class Api::UsersController < ActionController::API
  def checkin
    if params[:user_number].blank?
      render json: { result: false, message: '請帶入員工編號' }, status: 400
      return
    end
    user = User.find_by(user_number: params[:user_number])
    if user.blank?
      render json: { result: false, message: '找不到對應的員工' }, status: 404
      return
    end
    if user.update!(active: true)
      render json: { result: true, user: { name: user.name, department: user.department }, message: '登機成功' }, status: 200
    else
      render json: { result: false, message: '出現錯誤, 請聯絡工程師' }, status: 500
    end
  rescue => ex
    render json: { message: '抱歉，系統出現問題，請稍後再試', exception: ex.to_s }, status: 500
  end
end
