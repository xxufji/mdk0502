unit edit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TfEdit }

  TfEdit = class(TForm)
    data: TEdit;
    Save: TBitBtn;
    NotSave: TBitBtn;
    forma: TComboBox;
    Pol: TComboBox;
    fio: TEdit;
    speciality: TEdit;
    fiostudenta: TLabel;
    dateofbirthday: TLabel;
    Specialitystudenta: TLabel;
    formaobuchenia: TLabel;
    Polstudenta: TLabel;
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  fEdit: TfEdit;

implementation

{$R *.lfm}

{ TfEdit }

procedure TfEdit.FormShow(Sender: TObject);
begin
  fio.SetFocus;
end;

end.

