class JobsController < ApplicationController
  # GET /jobs
  def index
    jobs = Job.all
    categories = extract_categories_param
    jobs = jobs.where(category: categories) if categories.present?

    min_salary = params[:min_salary].presence || params[:minSalary].presence || params[:min_year].presence || params[:minYear].presence
    if min_salary.present?
      min_salary_i = Integer(min_salary)
      jobs = jobs.where("salary >= ?", min_salary_i)
    end

    jobs = jobs.order(created_at: :desc)
    page, per_page = extract_pagination
    total_count = jobs.count
    jobs = jobs.offset((page - 1) * per_page).limit(per_page)

    render json: {
      jobs: jobs,
      page: page,
      perPage: per_page,
      totalCount: total_count,
      totalPages: (total_count.to_f / per_page).ceil
    }
  rescue ArgumentError
    render json: { error: "min_salary must be an integer" }, status: :unprocessable_entity
  end

  # POST /jobs
  def create
    title = job_param(:title)
    category = job_param(:category)

    # フロント実装により `salary` ではなく `year` / `annualIncome` などが送られる可能性があるため吸収する
    salary_raw = job_param(:salary) || job_param(:year) || job_param(:income) || job_param(:annualIncome) || job_param(:annual_income)

    job = Job.new(
      title: title,
      category: category,
      salary: salary_raw
    )

    if job.save
      render json: job, status: :created
    else
      render json: { errors: job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /jobs/search?category=...&min_salary=...
  def search
    jobs = Job.all
    categories = extract_categories_param
    jobs = jobs.where(category: categories) if categories.present?

    min_salary = params[:min_salary].presence || params[:minSalary].presence || params[:min_year].presence || params[:minYear].presence
    if min_salary.present?
      min_salary_i = Integer(min_salary)
      jobs = jobs.where("salary >= ?", min_salary_i)
    end

    jobs = jobs.order(created_at: :desc)
    page, per_page = extract_pagination
    total_count = jobs.count
    jobs = jobs.offset((page - 1) * per_page).limit(per_page)

    render json: {
      jobs: jobs,
      page: page,
      perPage: per_page,
      totalCount: total_count,
      totalPages: (total_count.to_f / per_page).ceil
    }
  rescue ArgumentError
    render json: { error: "min_salary must be an integer" }, status: :unprocessable_entity
  end

  private

  def job_param(key)
    # フロント実装により `job: { ... }` か `...` 直渡しのどちらもあり得るため両対応
    # また、キーが Symbol/String どちらで来ても拾えるように両方チェックする
    if params[:job].present?
      params.dig(:job, key) || params.dig(:job, key.to_s)
    else
      params[key] || params[key.to_s]
    end
  end

  def extract_categories_param
    raw =
      params[:categories].presence ||
        params[:jobCategories].presence ||
        params[:category].presence

    return nil if raw.blank?

    categories =
      case raw
      when Array
        raw
      else
        raw.to_s.split(",")
      end

    categories.map { |c| c.to_s.strip }.reject(&:blank?).presence
  end

  def extract_pagination
    page_raw = params[:page].presence || 1
    per_page_raw = params[:perPage].presence || params[:per_page].presence || params[:limit].presence || 10

    page = Integer(page_raw)
    per_page = Integer(per_page_raw)

    page = 1 if page < 1
    per_page = 10 if per_page < 1
    per_page = 100 if per_page > 100

    [page, per_page]
  rescue ArgumentError, TypeError
    [1, 10]
  end
end

