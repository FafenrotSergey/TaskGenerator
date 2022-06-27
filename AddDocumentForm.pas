unit AddDocumentForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  DocumentCreater;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    headerText: TEdit;
    Label2: TLabel;
    editNumVariants: TSpinEdit;
    editFontSize: TSpinEdit;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  chosenDirectory: string;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  docCreater: TDocumentCreater;
begin
  docCreater := TDocumentCreater.create(editNumVariants.Value, editFontSize.Value, headerText.Text);
  docCreater.createDocument;
end;

end.
