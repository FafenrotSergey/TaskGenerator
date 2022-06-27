program GeneratorProject;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  BasicOperations in 'BasicOperations.pas',
  TaskBasicClass in 'TaskBasicClass.pas',
  TaskFindDeterminant in 'TaskFindDeterminant.pas',
  MatrixEquation in 'MatrixEquation.pas',
  ChooseController in 'ChooseController.pas',
  ConditionItems in 'ConditionItems.pas',
  ParseTaskToMemo in 'ParseTaskToMemo.pas',
  PropertyController in 'PropertyController.pas',
  AddDocumentForm in 'AddDocumentForm.pas' {Form2},
  DocumentCreater in 'DocumentCreater.pas',
  ParserToWord in 'ParserToWord.pas',
  TaskMultMatrix in 'TaskMultMatrix.pas',
  MatrixExpression in 'MatrixExpression.pas',
  TransposeMatrix in 'TransposeMatrix.pas',
  TaskInverseMatrix in 'TaskInverseMatrix.pas',
  RangMatrix in 'RangMatrix.pas',
  TaskSlu in 'TaskSlu.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
