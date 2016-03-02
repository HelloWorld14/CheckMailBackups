class ParseBody
  def initialize(body)
    @success_tasks = 0
    @fail_tasks = 0

    @body = body
    check
  end

  def success_tasks
    @success_tasks
  end

  def fail_tasks
    @fail_tasks
  end

  private

  def check
    lines = @body.split("\n")

    lines.each do |line|
      check_line(line)
    end
  end

  def check_line(line)
    if line =~ /\*\* Задание (".*?") завершено\. Ошибок: (\d*?,) /
      parse_report(line)
    end
  end

  def parse_report(report)
    errors_count = report.scan(/Ошибок: (\d*?,)/)
    errors_count = errors_count[0][0].to_i

    if errors_count == 0
      @success_tasks += 1 
    else
      @fail_tasks += 1
    end
  end
end




