# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require "csv"

module FatFreeCRM
  class ExportCSV
    # CSV export. Based on to_csv Rails plugin by Ary Djmal
    # https://github.com/arydjmal/to_csv
    #----------------------------------------------------------------------------
    def self.from_array(items = [])
      Enumerator.new do |y|
        # Infer column types from the first item in the array
        klass = items.first.class
        columns = klass.columns.map(&:name).reject { |column| column =~ /password|token/ }
        columns << 'tags' if klass.taggable?
        CSV.generate(col_sep: ';', encoding: 'iso-8859-1') do |csv|
          y << columns.map { |column| klass.human_attribute_name(column) }.to_csv
          items.each do |item|
            y << columns.map do |column|
              if column == 'tags'
                item.tag_list.join(' ')
              else
                item.send(column)
              end
            end.to_csv
          end
        end
      end
    end


  end
end
