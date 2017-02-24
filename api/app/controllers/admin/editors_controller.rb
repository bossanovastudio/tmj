class Admin::EditorsController < Admin::AdminController
  before_action :get_editor, except: [:index, :promote, :revoke]

  def index
    @editors = ::User.editors
  end

  def edit
  end

  def commit
    new_networks = params[:social_network]
      .keys
      .reject { |k| params[:social_network][k].empty? }
      .collect { |k| [k, params[:social_network][k]] }
    p = params.permit(:image, :editor_avatar_hover, :bio, :editor_color,
      :editor_icon, :editor_desktop_background, :editor_mobile_background,
      :editor_menu_background, :editor_recommendation_ribbon,
      :editor_recommendation_ribbon_animated)
    p.keys.each do |k|
      @editor.send("#{k}=", p[k])
    end
    new_networks.each do |n|
      net = @editor.editor_networks.find_or_initialize_by(kind: n[0])
      net.url = n[1]
    end
    removable_nets = ::EditorNetwork.kinds
      .keys
      .reject { |k| new_networks.collect { |n| n[0] }.include? k.to_s }
    @editor.editor_networks.where(kind: removable_nets).destroy_all unless removable_nets.empty?

    @editor.save
    redirect_to action: :index
  end

  def promote
    user = User.find_by(username: params[:username])
    raise ActionController::RoutingError.new('Not Found') unless user
    user.editor!
    render partial: 'editor', object: user
  end

  def revoke
    user = User.editors.find(params[:id])
    render json: { success: false } unless user
    user.user!
    render json: { success: true }
  end

  private
    def get_editor
      @editor = User.editors.find(params[:id])
    end
end
