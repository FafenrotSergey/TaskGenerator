unit ChooseController;
//класс контроллера выбора

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, Contnrs,
  TaskBasicClass, ParseTaskToMemo, TaskFindDeterminant, TaskMultMatrix,
  MatrixEquation, MatrixExpression, TransposeMatrix, TaskInverseMatrix, RangMatrix,
  TaskSlu;

type

  TChooseController = class
    private
      taskMultMat: TTaskMultMatrix;
      matExpr: TMatrixExpression;
      transposeMat: TTransposeMatrix;
      taskFindDet: TTaskFindDeterminant;
      taskInvMat: TTaskInverseMatrix;
      matEquat: TMatrixEquation;
      taskRang: TRangMatrix;
      slu: TTaskSlu;
      parserToMemo: TParseTaskToMemo;
      itemIndex: integer;

    public
      procedure createTask(index: integer);
      procedure createPreview(index: integer; output: TMemo; propContainer: TScrollBox);
      procedure deleteTask (index: integer; output: TMemo; propContainer: TScrollBox);
      procedure setItemIndex(index: integer);
      function getTaskList(index: integer): listPointer;
      function getNumTasks(index: integer): integer;
      constructor create();
  end;

implementation

{ TChooseController }

constructor TChooseController.create;
begin
  parserToMemo := TParseTaskToMemo.Create;
end;

procedure TChooseController.setItemIndex(index: integer);
begin
  itemIndex := index;
end;

procedure TChooseController.createTask(index: integer);
begin
  case index of
    0: taskMultMat := TTaskMultMatrix.create;
    1: matExpr := TMatrixExpression.create;
    2: transposeMat :=  TTransposeMatrix.create;
    3: taskFindDet := TTaskFindDeterminant.create;
    4: taskInvMat := TTaskInverseMatrix.create;
    5: matEquat := TMatrixEquation.create;
    6: taskRang := TRangMatrix.create;
    7: slu := TTaskSlu.create;
  end;
end;

procedure TChooseController.deleteTask(index: integer; output: TMemo; propContainer: TScrollBox);
var
  i: integer;
begin
  case index of
    0: taskMultMat.Free;
    1: matExpr.Free;
    2: transposeMat.Free;
    3: taskFindDet.Free;
    4: taskInvMat.Free;
    5: matEquat.Free;
    6: taskRang.Free;
    7: slu.Free;
  end;

  if index = itemIndex then
  begin
    output.Lines.Clear;

    for i := propContainer.ComponentCount - 1 downto 0 do
      propContainer.Components[i].Destroy;

  end;
end;




function TChooseController.getTaskList(index: integer): listPointer;
begin
  case index of
  0: result := taskMultMat.getListTaskItems;
  1: result := matExpr.getListTaskItems;
  2: result := transposeMat.getListTaskItems;
  3: result := taskFindDet.getListTaskItems;
  4: result := taskInvMat.getListTaskItems;
  5: result := matEquat.getListTaskItems;
  6: result := taskRang.getListTaskItems;
  7: result := slu.getListTaskItems;
  end;
end;

// выбираем количество задач
function TChooseController.getNumTasks(index: integer): integer;
begin
  case index of
  0: result := taskMultMat.getNumTasks;
  1: result := matExpr.getNumTasks;
  2: result := transposeMat.getNumTasks;
  3: result := taskFindDet.getNumTasks;
  4: result := taskInvMat.getNumTasks;
  5: result := matEquat.getNumTasks;
  6: result := taskRang.getNumTasks;
  7: result := slu.getNumTasks;
  end;
end;

procedure  TChooseController.createPreview(index: integer; output: TMemo; propContainer: TScrollBox);
var
  list: listPointer;
  i: integer;
begin
  // если блок со свойствами не пуст, то очищаем его
  if propContainer.ComponentCount > 0 then
  begin
    for i := propContainer.ComponentCount - 1 downto 0 do
    propContainer.Components[i].Destroy;
  end;

  case index of
    0: taskMultMat.createPropertyControllers(propContainer);
    1: matExpr.createPropertyControllers(propContainer);
    2: transposeMat.createPropertyControllers(propContainer);
    3: taskFindDet.createPropertyControllers(propContainer);
    4: taskInvMat.createPropertyControllers(propContainer);
    5: matEquat.createPropertyControllers(propContainer);
    6: taskRang.createPropertyControllers(propContainer);
    7: slu.createPropertyControllers(propContainer);
  end;
  output.Lines.Clear;
  list := getTaskList(index);
  parserToMemo.parseTask(list^, output);
  list^.Clear;
end;

end.
