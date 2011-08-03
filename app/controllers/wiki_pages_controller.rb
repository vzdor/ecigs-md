class WikiPagesController < ApplicationController

  before_filter :get_wiki_page, :only => [:show, :edit, :update]

  def new
    @wiki_page = WikiPage.new
  end

  def index
    @wiki_pages = WikiPage.find(:all) # visible
  end

  def create
    @wiki_page = WikiPage.new(params[:wiki_page])
    if @wiki_page.save
      flash[:notice] = "Wiki added."
      redirect_to @wiki_page
    else
      render :action => "new"
    end
  end

  def update
    @wiki_page.attributes = params[:wiki_page]
    if @wiki_page.save
      flash[:notice] = "Wiki updated."
      redirect_to @wiki_page
    else
      render :action => "edit"
    end
  end

  protected

  def get_wiki_page
    @wiki_page = WikiPage.visible.find_by_slug!(params[:id])
  rescue ActiveRecord::RecordNotFound
    is_admin? ? redirect_to(new_wiki_page_path) : raise
  end

  def set_tab
    @tab = :faq
  end
end
