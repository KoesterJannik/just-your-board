module ApplicationHelper
    def priority_color_class(priority)
        case priority
        when 'high'
          'text-red-600 text-sm font-medium'
        when 'medium'
          'text-yellow-600 text-sm font-medium'
        when 'low'
          'text-blue-600 text-sm font-medium'
        end
      end

      def priority_border_color_class(priority)
        case priority
        when 'high'
          'border-2 border-red-600'
        when 'medium'
          'border-2 border-yellow-600'
        when 'low'
          'border-2 border-blue-600'
        end
      end
      
end
