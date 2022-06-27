unit CreateBlockController;

// ������ ��� �������� ������-������������ �� ����� �������� ���������

interface

uses
  System.Classes, BlockController, TaskFindDeterminant;



var
  taskList: TList; //������ �������� �����


procedure createBlocks();

implementation

procedure createTaskList(); //������� ������� ����� � ������ �� ���� ��������
begin                       //���� ���� ��������� ������
  taskList := TList.create;
  taskList.Add(TTaskFindDeterminant.create(3));
end;

procedure createBlocks(); // ������� �����-����������� ��� ������ ������ �� ������
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
