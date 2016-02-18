class HomeController < AuthenticatedController
  def index
    # @products = ShopifyAPI::Product.find(:all, :params => {:product_type => "Underarmour"})
    
    @scripts = ShopifyAPI::ScriptTag.all
    # script = ShopifyAPI::ScriptTag.new(:all, :params => {:event => "onload", :src => "https://shopperapproved.herokuapp.com/sajs/14043.js"})
  end

  def new
  end
  # https://shopperapproved.herokuapp.com/sajs/14043.js
  def create
    script_url = params[:home][:name]
    script = subject_params[:name]
    path =  "public/#{script}" + ".js"
    content = 'if(window.location.href.indexOf("thank_you") > -1) {var sa_values = { "site":'"#{script}"', "forcecomments":1 };  function saLoadScript(src) { var js = window.document.createElement("script"); js.src = src; js.type = "text/javascript"; document.getElementsByTagName("head")[0].appendChild(js); } var d = new Date(); if (d.getTime() - 172800000 > 1454671334000) saLoadScript("https://www.shopperapproved.com/thankyou/rate/'"#{script}"'"); else saLoadScript("https://direct.shopperapproved.com/thankyou/rate/'"#{script}"'.js?d=" + d.getTime());}'    
    File.open(path,'w+') do |f|
      f.write(content)
    end

  	ShopifyAPI::ScriptTag.create(:event => "onload", :src => "https://shopperapproved.herokuapp.com/sajs/#{script}.js", :body => "#{script}")
    flash[:notice] = "Shopper Approved Script Generated to Checkout page!"
    redirect_to(:action => 'index')
  end


  def delete
    src = ShopifyAPI::ScriptTag.delete(params[:id])
    flash[:notice] = "Shopper Approved Script Removed from Checkout page!"
    redirect_to(:action => 'index')
  end

  private
      def subject_params
        params.require(:home).permit(:name)
      end
end