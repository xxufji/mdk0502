unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

type
  myForm = record  //запись
    Left: integer;  //левая граница формы
    Top: integer;  //верхняя
    Height: integer;  //высота формы
    Width: integer;  //ширина
    Caption: string[100];  //заголовок
    Checked: boolean;  //состояние флажка CheckBox1
    wsMax: boolean;  //окно развернуто?
  end; //record


var
  Form1: TForm1;
  MyF: myForm;  //наша переменная-запись

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  if Edit1.Text <> '' then Form1.Caption:= Edit1.Text;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
    f: file of myForm;  //типизированный файл для сохранения данных
begin
  //сначала настроим переменную-запись:
  //не сохраняем размеры и положение, если окно wsMaximized:
  if not (Form1.WindowState = wsMaximized) then begin
    MyF.Left:= Form1.Left;
    MyF.Top:= Form1.Top;
    MyF.Height:= Form1.Height;
    MyF.Width:= Form1.Width;
    MyF.wsMax:= False;
  end
  else MyF.wsMax:= True;
  //остальные настройки:
  MyF.Caption:= Form1.Caption;
  MyF.Checked:= CheckBox1.Checked;
  //теперь создаем или перезаписываем файл настроек:
  try
    AssignFile(f, 'MyProg.dat');
    Rewrite(f);
    Write(f, MyF); //записываем в файл данные из записи
  finally
    CloseFile(f);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  f: file of myForm;  //типизированный файл для сохранения данных
begin
  //если файла еще нет, просто выходим:
  if not FileExists('MyProg.dat') then exit;
  //иначе открываем файл и считываем из него настройки в запись:
  try
    AssignFile(f, 'MyProg.dat');
    Reset(f);
    Read(f, MyF); //считали данные в переменную типа запись
  finally
    CloseFile(f);
  end;
  //теперь настройки нужно применить к форме:
  //если окно было развернуто, разворачиваем его, иначе настраиваем края:
  if MyF.wsMax then Form1.WindowState:= wsMaximized
  else begin
    Form1.Left:= MyF.Left;
    Form1.Top:= MyF.Top;
    Form1.Height:= MyF.Height;
    Form1.Width:= MyF.Width;
  end;
  //остальные настройки:
  Form1.Caption:= MyF.Caption;
  CheckBox1.Checked:= MyF.Checked;
end;




end.

