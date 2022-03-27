class TasksController < ApplicationController
  before_aciton :task_id_nil?, only: [:edit, :update, :destroy]

  # ActiveRecordを継承したインスタンスオブジェクトをview側で使用しない。
  def index
    # Array
    tasks = Task.where(done_flag: 0).order(created_at: :desk).pluck(:id, :image_status, :content, :created_at)
    tasks_view_model = PresenterIndex.new(tasks_ary: tasks)
    render("index", locals: {tasks: tasks_view_models})
  end

  def fin_index
    tasks = Task.where(done_flag: 0).order(created_at: :desk).pluck(:id, :image_status, :content, :created_at)
    tasks_view_model = PresenterIndex.new(tasks_ary: tasks)
    render("fin_index", locals: {tasks: tasks_view_model})
  end


  def new
    task = Task.new #Task<ActiveRecord>
    task_content = task.content #String or nil
    task_errors = task.errors #Hash #ActiveModel::Errors
    task_view_model = PresenterNew.new(content: task_content, errors: task_errors) #PresenterNew
    render("new", locals: {task: task_view_model})
  end

  def create
    #Task<ActiveRecord>
    task = Task.new(
      content: params[:content],#String or NilClass
      done_flag: 0,#NilClass or Integer
      image_status: "undone.png" #NilClass or String
    )
    if task.save
      redirect_to("/")
    else
      task_content = task.content #String or NilClass
      task_errors = task.errors #Hash #ActiveModel::Errors
      task_view_model = PresenterNew.new(content: task_content, errors: task_errors) #PresenterNew
      render("new", locals: {task: task_view_model})
    end
  end

  def edit
    task = Task.find_by(id: params[:id]) #Task<ActiveRecord>
    task_id = task.id #Integer
    task_content = task.content #String or nil
    task_errors = task.errors #Hash #ActiveModel::Errors
    task_view_model = PresenterEdit.new(content: task_content, errors: task_errors, id: task_id) #PresentreEdit
  end

  def update
    task = Task.find_by(id: params[:id]) #Task<ActiveRecord>
    task_content = params[:content] #String
    if task.save
      flash[:notice] = "やることを編集しました"
      redirect_to("/")
    else
      task_id = task.id #Integer
      task_content = task.content #String or nil
      task_errors = task.errors #ActiveModel::Errors
      task_view_model = PresenterEdit.new(content: task_content, errors: task_errors, id: task_id) #PresentreEdit
      render("edit", locals: {task: tasks_view_model})
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])
    if task.destroy
      flash[:notice] = "タスクを削除しました"
      redirect_to(request.referer)
    else
      flash[:notice] = "タスクの削除に失敗しました"
      redirect_to(request.referer)
    end
  end

  def done
    task = Task.find_by(id: params[:id])
    task.done_flag = 1
    task.image_status = "done.png"
    if task.save
      redirect_to("/")
    else
      flash[:notice] = "保存に失敗しました"
      redirect_to(request.referer)
    end
  end

  def undone
    task = Task.find_by(id: params[id])
    task.done_flag = 0
    task.image_status = "undone.png"
    if task.save!
      redirect_to("/tasks/fin_index")
    else
      flash[:notice] = "保存に失敗しました"
      redirect_to(request.referer)
    end
  end
end



