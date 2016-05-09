class Paginator
  attr_reader :page, :num_of_records, :name

  def initialize(options = {})
    @page = page_limit(options[:page])
    @num_of_records = record_limit(options[:limit])
    @name = options[:q]
  end

  def paginate(obj, arr)
    obj = obj.where('lower(name) LIKE ?', "%#{name.downcase}%") unless name.nil?
    last_page = total_pages(obj.count, num_of_records)
    { total_records: obj.count,
      page: "#{page + 1} of #{last_page}",
      bucket_list: obj.limit(num_of_records).offset(offset).select(arr) }
  end

  private

  def offset
    page * num_of_records
  end

  def record_limit(num)
    num = num.to_i
    num = 20 if num.nil? || num == 0
    return 100 if num > 100
    num
  end

  def page_limit(value)
    value = value.to_i
    value = 1 if value.nil? || value == 0
    value - 1
  end

  def total_pages(total_records, min = 20)
    result = total_records / min
    return 1 if total_records <= min
    return result if (total_records % min) == 0
    return result + 1 if (total_records % min) < min
  end
end
