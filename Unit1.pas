unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst,
  ChooseController, Contnrs, Vcl.ExtCtrls, Vcl.Samples.Spin, AddDocumentForm;

type

  TForm1 = class(TForm)
    Memo1: TMemo;
    CheckListBox1: TCheckListBox;
    Button1: TButton;
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    Label2: TLabel;
    Button2: TButton;

    procedure Form1Create(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private


  public
    chooseController: TChooseController;
    { Public declarations }
  end;


var
  Form1: TForm1;

implementation

{$R *.dfm}

//Добавление элементов в список чекбоксов

procedure TForm1.Form1Create(Sender: TObject);
begin
  CheckListBox1.Items.Add('Найти произведение двух матриц');
  CheckListBox1.Items.Add('Решить матричное выражение');
  CheckListBox1.Items.Add('Транспонировать матрицу');
  CheckListBox1.Items.Add('Найти определитель матрицы');
  CheckListBox1.Items.Add('Найти обратную матрицу');
  CheckListBox1.Items.Add('Решить матричное уравнение');
  CheckListBox1.Items.Add('Найти ранг матрицы');
  CheckListBox1.Items.Add('Исследовать систему уравнений');

end;


procedure TForm1.Button2Click(Sender: TObject);
begin
  Label1.Visible := false;
  Label2.Visible := false;
  Button2.Visible := false;
  CheckListBox1.Visible := true;
  ScrollBox1.Visible := true;
  Memo1.Visible := true;
  Button1.Visible := true;
  chooseController := TChooseController.create;
  Randomize;
end;

procedure TForm1.CheckListBox1ClickCheck(Sender: TObject);
var
  i: integer;
  btnFlag: boolean;
begin
  if CheckListBox1.checked[CheckListBox1.ItemIndex] then
  begin
    chooseController.setItemIndex(CheckListBox1.ItemIndex);
    chooseController.createTask(CheckListBox1.ItemIndex);
    chooseController.createPreview(CheckListBox1.ItemIndex, Memo1, ScrollBox1);
  end
  else if NOT CheckListBox1.checked[CheckListBox1.ItemIndex] then
    chooseController.deleteTask(CheckListBox1.ItemIndex, Memo1, ScrollBox1);

  btnFlag := false;

  for i := 0 to CheckListBox1.Items.Count - 1 do
  begin
    if CheckListBox1.Checked[i] then
    begin
      btnFlag := true;
      break;
    end;
  end;

  if btnFlag then
    Button1.Enabled := true
  else
    Button1.Enabled := false;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

end.

