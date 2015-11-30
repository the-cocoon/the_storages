# include ::TheStorages::Controller
module TheStorages
  module Controller
    extend ActiveSupport::Concern

    included do
      include TheSortableTreeController::Rebuild
      before_action :find_storage, only: %w[ create ]
    end

    def create
      @new_file = @storage.attached_files.new(attachment: get_file)

      if @new_file.save
        if @new_file.is_image?
          @new_file.create_version_original
          @new_file.create_version_base
          @new_file.create_version_preview
        end

        render template: json_response('create.success')
      else
        render template: json_response('create.errors'), status: 422
      end
    end

    def destroy
      @attachment = ::AttachedFile.find(params[:id])
      @attachment.destroy_versions
      @attachment.destroy

      render template: json_response('destroy.success')
      # redirect_to [ request.referer, :files ].join('#')
    end

    private

    def get_file
      file = params[:file]        if params[:file]
      file = params[:files].first if params[:files]
      file
    end

    def find_storage
      id    = params[:storage_id]
      klass = params[:storage_type].constantize
      @storage = klass.friendly_first(id)
    end

    def json_response template
      "the_storages/#{ template }.json.jbuilder"
    end
  end
end
