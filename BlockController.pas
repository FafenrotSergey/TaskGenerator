unit BlockController;

//класс блока-контроллера для задачи

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TBlockController = Class

    private
      blockId: integer;
      block: TGroupBox;
      taskName: TLabel;
      addButton: TButton;
      previewButton: TButton;
      settingButton: TButton;
    public
      function getBlockId(): integer;
      constructor create(parentElem: TScrollBox; id: integer; title: string);

  End;

implementation

{ TBlockControl }

constructor TBlockController.create(parentElem: TScrollBox; id: integer; title: string);
begin
  blockId := id;
  block := TGroupBox.create(parentElem);
  block.Parent := parentElem;
  block.Caption := '';
  block.Height := 80;
  block.Align := alTop;

  taskName := TLabel.create(block);
  taskName.Parent := block;
  taskName.Font.Size := 12;
  taskName.Top := 10;
  taskName.Left := 10;
  taskName.Caption := title;

  addButton := TButton.create(block);
  addButton.Parent := block;
  addButton.Top := 40;
  addButton.Left := 10;
  addButton.Caption := 'Добавить';

  previewButton := TButton.create(block);
  previewButton.Parent := block;
  previewButton.Top := 40;
  previewButton.Left := 90;
  previewButton.Caption := 'Пример';

  previewButton := TButton.create(block);
  previewButton.Parent := block;
  previewButton.Top := 40;
  previewButton.Left := 170;
  previewButton.Caption := 'Настроить';

end;

function TBlockController.getBlockId: integer;
begin
  result := blockId;
end;

end.
