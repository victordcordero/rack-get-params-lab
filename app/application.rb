
class Application

  @@items = [ "Apples", "Carrots", "Pears" ]
  @@cart = [  ]

  def call( env )
    response = Rack::Response.new
    request = Rack::Request.new( env )
    if request.path.match( /items/ )
      @@items.each do | item |
        response.write "#{ item }\n"
      end
    elsif request.path.match( /search/ )
      search_term = request.params[ "q" ]
      response.write handle_search( search_term )
    elsif request.path.match( /cart/ )
      response.write display_cart
    elsif request.path.match( /add/ )
      item_to_search_for = request.params[ "item" ]
      response.write add_to_cart( item_to_search_for )
    else
      response.write "Path Not Found"
    end
    response.finish
  end

  def handle_search( search_term )
    if @@items.include?( search_term )
      return "#{ search_term } is one of our items"
    else
      return "Couldn't find #{ search_term }"
    end
  end

  def display_cart
    if @@cart.empty?
      return "Your cart is empty"
    else
      return @@cart.inject(""){ | list, item | list + "#{ item }\n" }
    end
  end

  def add_to_cart( item )
    if @@items.include?( item )
      @@cart << item
      return "added #{ item }"
    else
      return "We don't have that item"
    end
  end
  
end