module Inventoryable

  def self.included(klass)
    klass.extend(ClassMethods)
    klass.extend(Enumerable)
  end

  module ClassMethods
    def create(attributes)
      object = new(attributes)
      instances.push(object)
      return object
    end

    def instances
      @instances ||= []
    end

    def each(&block)
      instances.each(&block)
    end

    def report(title, items)
      puts "_" * 50
      puts title
      puts "-" * 50
      items.each do |item|
        line = []
        line.push("Item: #{item.attributes[:name]}")
        if item.attributes.include?(:size)
          line.push("Size: #{item.attributes[:size]}")
        end
        puts line.join("\t")
      end
      puts "-" * 50
      puts "\n"
    end

    def in_stock_report
      puts "#{self.to_s} In stock Report"
      reportable = instances.select{ |instance| instance.in_stock? }
      report(title, reportalbe)
    end

    def out_of_stock_report
      title = "#{self.to_s} Out of Stock Report"
      reportable = instances.select{ |instances| !instances.in_stock? }
      repot(title, repotable)
    end  

  end

  def stock_count
    @stock_count ||= 0
  end

  def stock_count=(number)
    @stock_count = number
  end

  def in_stock?
    stock_count > 0
  end

end

class Shirt
  include Inventoryable
  attr_accessor :attributes

  def initialize(attributes)
    @attributes = attributes
  end
end

class Pant
  include Inventoryable
  attr_accessor :attributes

  def initialize(attributes)
    @attributes = attributes
  end
end

class Accessory
  include Inventoryable
  attr_accessor :attributes

  def initialize(attributes)
    @attributes = attributes
  end
end

shirt = Shirt.create(name: "MTF", size: "L")
shirt.stock_count = 10

shirt = Shirt.create(name: "MTF2", size: "L")

shirt = Shirt.create(name: "MTF", size: "M")
shirt.stock_count = 9

pant = Pant.create(name: "Jeans", size: "M")
pant.stock_count = 2

pant = Pant.create(name: "Jeans", size: "S")
pant.stock_count = 4

accessory = Accessory.create(name: "Belt", size: "M")
accessory.stock_count = 1

accessory = Accessory.create(name: "Belt", size: "L")
accessory.stock_count = 1

accessory = Accessory.create(name: "Necklace")
accessory.stock_count = 1

Shirt.in_stock_report
Pant.in_stock_report
Accessory.in_stock_report
