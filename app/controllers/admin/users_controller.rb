module Admin

  class UsersController < ::Admin::BaseController
    before_action :redirect_to_cleared_ransack_query!, only: [:index]
    before_action :instance
    before_action :authorize_crud!
    before_action :store_referer, only: [:edit, :show, :index]
    before_action :set_meta_title!, only: [:index, :show]
    before_action :add_index_breadcrumb
    before_action :add_instance_breadcrumb, only: [:show, :edit, :update]

    def index
      @q = relation.ransack(params[search_key], search_key: search_key)
      @instances = @q.result.order(id: :desc).page(params[:page]).per(params[:per])
      respond_with @instances, exporter: 'Admin::UserExporter', filename: "使用者資料-#{Time.current.to_i}"
    end

    def show; end

    def new
      self.action_name = 'new'
      set_meta_title!
      if request.xhr?
        formats << :html
        render layout: false
      else
        add_breadcrumb t('.breadcrumb')
      end
    end

    def edit
      self.action_name = 'edit'
      set_meta_title!
      if request.xhr?
        formats << :html
        render layout: false
      else
        add_breadcrumb t('.breadcrumb')
      end
    end

    def create
      if instance.save
        log_activity!(current_role, instance, saved_changes: true) if Tyr.config.activity.enable
        if request.xhr?
          render
        else
          redirect_back_to admin_user_path(instance), flash: { success: t('.success', **locale_params) }, skip_referer: true
        end
      elsif request.xhr?
        render
      else
        new
        flash.now[:error] = instance.errors.full_messages.to_sentence
        render :new
      end
    end

    def update
      if instance.update(instance_params)
        log_activity!(current_role, instance, saved_changes: true) if Tyr.config.activity.enable
        if request.xhr?
          render plain: 'ok'
        else
          redirect_back_to edit_admin_user_path(instance), flash: { success: t('.success', **locale_params) }
        end
      else
        edit
        flash.now[:error] = instance.errors.full_messages.to_sentence
        render :edit
      end
    end

    def destroy
      if instance.destroy
        log_activity!(current_role, instance, saved_changes: true) if Tyr.config.activity.enable
        if request.xhr?
          render plain: 'ok'
        else
          redirect_back_to admin_users_path, flash: { success: t('.success', **locale_params) }, skip_referer: true
        end
      elsif request.xhr?
        render plain: 'ok'
      else
        redirect_back_to admin_users_path, flash: { error: instance.errors.full_messages.to_sentence }
      end
    end

    private

    def klass
      @klass ||= Admin::User
    end

    def relation
      @relation ||= klass
    end

    def instance
      object_name
      @instance ||= if params[:id]
                      relation.find(params[:id])
                    elsif params[:clone_from]
                      relation.find_by(id: params[:clone_from])&.dup || relation.new(instance_params)
                    else
                      relation.new(instance_params)
                    end
    end

    def instance_params
      @instance_params ||= params.fetch(object_name, {}).permit!
    end

    def set_meta_title!
      set_meta(title: locale_params) if Tyr.config.meta_tags.enable
    end

    def locale_params
      { model_name: klass.model_name.human }.merge(@instance.try(:id) ? { label: @instance.label } : {})
    end

    def object_name
      @object_name ||= params[:object_name].presence || :user
    end

    def search_key
      @search_key ||= params[:search_key].presence || :q_user
    end

    def add_index_breadcrumb
      set_default_breadcrumb
    end

    def add_instance_breadcrumb
      add_breadcrumb(instance.label, url_for(action: :show, id: instance.id))
    end

    def current_role
      current_administrator
    end
  end
end
