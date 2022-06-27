unit PropertyController;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin;

type

  intPointer = ^integer;

  TPropertyController = class
    private
      propertyPointer: intPointer;
      propertyBlock: TGroupBox;
      propertyName: TLabel;
      propertyEdit: TSpinEdit;
    public
      procedure propertyEditChange(Sender: TObject);
      constructor create(parent: TScrollBox; propName: string; pointer: intPointer);
  end;

implementation

{ TPropertyController }

constructor TPropertyController.create(parent: TScrollBox; propName: string; pointer: intPointer);
begin
  propertyPointer := pointer;

  propertyBlock :=  TGroupBox.Create(parent);
  propertyBlock.Parent := parent;
  propertyBlock.Caption := '';
  propertyBlock.Height := 60;
  propertyBlock.Align := alTop;

  propertyName := TLabel.Create(propertyBlock);
  propertyName.Parent := propertyBlock;
  propertyName.Font.Size := 12;
  propertyName.Caption := propName;
  propertyName.Left := 5;


  propertyEdit := TSpinEdit.Create(propertyBlock);
  propertyEdit.Parent := propertyBlock;
  propertyEdit.Top := 30;
  propertyEdit.Left := 5;
  propertyEdit.Value := pointer^;
  propertyEdit.OnChange := propertyEditChange;
end;

procedure TPropertyController.propertyEditChange(Sender: TObject);
begin
  propertyPointer^ := propertyEdit.Value;
end;

end.
