module BearHelper
  class ScriptFilter
    HISTORY_FILE_PATH = "#{ENV['HOME']}/.alfred_wf_search_bear_note_history"

    def initialize(query)
      @query = query
    end

    def perform
      result = get_top_10
      result.unshift(@query) if @query.to_s.size > 0
      to_xml(result)
    end

    private

    def to_xml(result)
      r = result.map {|item| "<item arg=\"#{item.split(" ").last}\"><title>#{item}</title></item>" }.join("")
      %{<xml><items>#{r}</items></xml>}
    end

    def get_top_10
      ordered_keywords = history_content.strip.split("\n").inject({}) do |hash, item|
        hash[item] ||= 0
        hash[item] += 1
        hash
      end.sort_by { |k, v| -v }

      if @query.to_s.size > 0
        ordered_keywords.select! { |keyword, _| keyword.include?(@query) }
      end

      ordered_keywords[0..10].map { |keyword, _| keyword }
    end

    def history_content
      return "" if !File.exists?(HISTORY_FILE_PATH)
      File.read(HISTORY_FILE_PATH)
    end
  end
end
