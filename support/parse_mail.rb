class ParseBody

  attr_reader :tasks

  def initialize(body)
    @success_tasks = 0
    @fail_tasks = 0
    @tasks = []

    @body = body
    check
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
    task_name = report.scan(/".*?"/)[0].gsub(/"/, "")
    errors_count = report.scan(/Ошибок: (\d*?,)/)
    errors_count = errors_count[0][0].to_i
    status = errors_count > 0 ? "fail" : "success"
    task = {name: task_name, status: status, errors_count: errors_count}
    @tasks.push(task)
    if errors_count == 0
      @success_tasks += 1
    else
      @fail_tasks += 1
    end
  end
end




