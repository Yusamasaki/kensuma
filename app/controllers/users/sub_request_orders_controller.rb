module Users
  class SubRequestOrdersController < Users::Base
    before_action :set_request_order

    def index; end

    def new
      @sub_request_order = @request_order.order.request_orders.build
      @businesses = Business.where.not(id: current_business)
    end

    def create
      @sub_request_order = @request_order.order.request_orders.build(sub_request_order_params)
      if @sub_request_order.save
        flash[:success] = '下請けへの発注依頼を作成しました'
        redirect_to users_request_order_url(@request_order)
      else
        render :new
      end
    end

    def update; end

    private

    def set_request_order
      @request_order = current_business.request_orders.find_by(uuid: params[:request_order_uuid])
    end

    def sub_request_order_params
      params.require(:request_order).permit(:business_id, :parent_id).merge(parent_id: @request_order.id)
    end
  end
end