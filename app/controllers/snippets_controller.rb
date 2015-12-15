class SnippetsController < ApplicationController
  # def new
  #  render json: {uid: SecureRandom.urlsafe_base64}, status: :ok
  # end

  def show
    if snippet
      render :show
    else
      head :not_found
    end
  end

  def create
    @snippet = Snippet.create!(snippet_params)
    render :show, status: :created
  end

  def update
    return head :bad_request if snippet.is_frozen
    snippet.update_attributes!(snippet_params)
    render :show
  end

  def freeze
    if snippet.is_frozen
      head :bad_request
    else
      snippet.freeze_snippet
      head :ok
    end
  end

  def fork
    @snippet = snippet.fork
    render :show
  end

  def snippet_params
    params.require(:snippet).permit(:code, :spec, :uid)
  end
  private :snippet_params

  def snippet
    @snippet ||= Snippet.where(id: params[:id]).first
  end
  private :snippet
end
