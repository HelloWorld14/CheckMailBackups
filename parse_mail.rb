class ParseBody
  def initialize(body)
    @body = body
    check
  end

  def success_tasks
    "Заданий выполнено: #{ @success_tasks }"
  end

  def fail_tasks
    "Заданий провалено: #{ @fail_tasks }"
  end

  private

  def check
    strings = @body.split("\n")

    @success_tasks = 0
    @fail_tasks = 0

    strings.each do |s|
      if s =~ /\*\* Задание (".*?") завершено\. Ошибок: (\d*?,) /
        errors_count = s.scan(/Ошибок: (\d*?,)/)
        errors_count = errors_count[0][0].to_i
        if errors_count == 0
          @success_tasks += 1 
        else
          @fail_tasks += 1
        end
      end
    end
  end
end




