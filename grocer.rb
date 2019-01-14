def consolidate_cart(cart)
  # code here
  temp = {}
  
   cart.each do |item|
    item.each do |food, att|
      if !temp.has_key?(food)
        temp[food] = { :price => att[:price], :clearance => att[:clearance], :count => 1 }
      else
        temp[food][:count] += 1
      end
    end
  end
  
  return temp
end

def process_coupon(cart, coupon)

    numofcoupons = coupon[:num]
    itemForCoupon = coupon[:item]
    numberofcoupons = coupon[:num].to_i
  
    if cart.has_key?(itemForCoupon) && cart[itemForCoupon][:count] >= numberofcoupons
      cart[itemForCoupon][:count] = cart[itemForCoupon][:count] - numofcoupons
      cart["#{itemForCoupon} W/COUPON"] ||= {}
      
      cart["#{itemForCoupon} W/COUPON"][:clearance] = cart[itemForCoupon][:clearance]
      cart["#{itemForCoupon} W/COUPON"][:price] = coupon[:cost]
      cart["#{itemForCoupon} W/COUPON"][:count] ||= 0
      cart["#{itemForCoupon} W/COUPON"][:count] += 1
    end
  end
  

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |couponitem|
    
    process_coupon(cart, couponitem)
  end
    #cart
    return cart
end

def apply_clearance(cart:[])
  # code here
   cart.each do |item, att|
    if att[:clearance] == true
      
      clearanceprice = att[:price] * 0.8
      att[:price] = clearanceprice.round(2)
    end
  end
  
end

def checkout(cart: [], coupons: [])
  # code here
    consolidatedCart = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidatedCart)
  clearance_applied = apply_clearance(cart: coupons_applied)

  total = 0

  clearance_applied.each do |item, att|
    total += (att[:count] * att[:price])
  end

  if total > 100
    total *=  0.90
  end

  return total.round(2)
end
