class Paginator
  @min = 20; @max = 100 
  def self.limit(value = @min)
    value = value.to_i
    if (value < @min)
      @min 
    elsif (value > @max)
      @max 
    else 
       value 
    end 
   end

   def self.page(value = 1)
     value.to_i - 1 
   end

   def self.total_pages(total_records)
     if total_records <= @min 
       1
     elsif (total_records % @min) == 0 
       total_records / @min 
     elsif (total_records % @min) < @min  
         (total_records / @min) + 1 
     end 
   end 
end 
