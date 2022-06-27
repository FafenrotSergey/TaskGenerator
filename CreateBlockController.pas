unit CreateBlockController;

// модуль для создания блоков-контроллеров во время загрузки программы

interface

uses
  System.Classes, BlockController, TaskFindDeterminant;



var
  taskList: TList; //список объектов задач


procedure createBlocks();

implementation

procedure createTaskList(); //создаем объекты задач и список из этих объектов
begin                       //сюда надо добавлять задачи
  taskList := TList.create;
  taskList.Add(TTaskFindDeterminant.create(3));
end;

procedure createBlocks(); // создаем блоки-контроллеры для каждой задачи из списка
var
  i: integer;
begin

  createTaskList();

  for i := 0 to taskList.Count - 1 do
  begin
    TBlockController.create(taskList[i].getTaskId, taskList[i].getTaskName);
  end;

end;

end.
