unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  Grids, edit;

type

  { TfMain }

  TfMain = class(TForm)
    Panel1: TPanel;
    Dobavit: TSpeedButton;
    Redact: TSpeedButton;
    Udalit: TSpeedButton;
    Sortirovat: TSpeedButton;
    SG: TStringGrid;
    procedure DobavitClick(Sender: TObject);
    procedure UdalitClick(Sender: TObject);
    procedure RedactClick(Sender: TObject);
    procedure SortirovatClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

type
  Market = record
    fio: string[100];
    data: integer;
    Warehouse: boolean;
    speciality: string[100];
    Pol: string[100];
  end; //record

var
  fMain: TfMain;
  adres: string; //адрес, откуда запущена программа

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.DobavitClick(Sender: TObject);
begin
  //очищаем поля, если там что-то есть:
  fEdit.fio.Text:= '';
  fEdit.data.Text:= '';
  fEdit.Pol.Text:= '';
  fEdit.speciality.Text:= '';
  //устанавливаем ModalResult редактора в mrNone:
  fEdit.ModalResult:= mrNone;
  //теперь выводим форму:
  fEdit.ShowModal;
  //если пользователь ничего не ввел - выходим:
  if (fEdit.fio.Text = '') or (fEdit.data.Text = '') or (fEdit.Pol.Text = '') or (fEdit.speciality.Text = '') then exit;
  //если пользователь не нажал "Сохранить" - выходим:
  if fEdit.ModalResult <> mrOk then exit;
  //иначе добавляем в сетку строку, и заполняем её:
  SG.RowCount:= SG.RowCount + 1;
  SG.Cells[0, SG.RowCount-1]:= fEdit.fio.Text;
  SG.Cells[1, SG.RowCount-1]:= fEdit.data.Text;
  SG.Cells[2, SG.RowCount-1]:= fEdit.speciality.Text;
  SG.Cells[3, SG.RowCount-1]:= fEdit.forma.Text;
  SG.Cells[4, SG.RowCount-1]:= fEdit.Pol.Text;
end;

procedure TfMain.UdalitClick(Sender: TObject);
begin
  //если данных нет - выходим:
  if SG.RowCount = 1 then exit;
  //иначе выводим запрос на подтверждение:
  if MessageDlg('Требуется подтверждение',
                'Вы действительно хотите удалить товар "' +
                SG.Cells[0, SG.Row] + '"?',
      mtConfirmation, [mbYes, mbNo, mbIgnore], 0) = mrYes then
         SG.DeleteRow(SG.Row);
end;

procedure TfMain.RedactClick(Sender: TObject);
begin
  //если данных в сетке нет - просто выходим:
  if SG.RowCount = 1 then exit;
  //иначе записываем данные в форму редактора:
  fEdit.fio.Text:= SG.Cells[0, SG.Row];
  fEdit.data.Text:= SG.Cells[1, SG.Row];
  fEdit.speciality.Text:= SG.Cells[2, SG.Row];
  fEdit.forma.Text:= SG.Cells[3, SG.Row];
  fEdit.Pol.Text:= SG.Cells[4, SG.Row];
  //устанавливаем ModalResult редактора в mrNone:
  fEdit.ModalResult:= mrNone;
  //теперь выводим форму:
  fEdit.ShowModal;
  //сохраняем в сетку возможные изменения,
  //если пользователь нажал "Сохранить":
  if fEdit.ModalResult = mrOk then begin
    SG.Cells[0, SG.Row]:= fEdit.fio.Text;
    SG.Cells[1, SG.Row]:= fEdit.data.Text;
    SG.Cells[2, SG.Row]:= fEdit.speciality.Text;
    SG.Cells[3, SG.Row]:= fEdit.forma.Text;
    SG.Cells[4, SG.Row]:= fEdit.Pol.Text
  end;
end;

procedure TfMain.SortirovatClick(Sender: TObject);
begin
  //если данных в сетке нет - просто выходим:
  if SG.RowCount = 1 then exit;
  //иначе сортируем список:
  SG.SortColRow(true, 0);
end;

procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  MyMarket: Market; //для очередной записи
  f: file of Market; //файл данных
  i: integer; //счетчик цикла
begin
  //если строки данных пусты, просто выходим:
  if SG.RowCount = 1 then exit;
  //иначе открываем файл для записи:
  try
    AssignFile(f, adres + 'telephones.dat');
    Rewrite(f);
    //теперь цикл - от первой до последней записи сетки:
    for i:= 1 to SG.RowCount-1 do begin
      //получаем данные текущей записи:
      MyMarket.fio:= SG.Cells[0, i];
      MyMarket.data := StrToInt(SG.Cells[1, i]);
      MyMarket.Warehouse := StrToBool(SG.Cells[2, i]);
      MyMarket.speciality:= SG.Cells[3, i];
      MyMarket.Pol:= SG.Cells[4, i];
      //записываем их:
      Write(f, MyMarket);
    end;
  finally
    CloseFile(f);
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  MyMarket: Market; //для очередной записи
  f: file of Market; //файл данных
  i: integer; //счетчик цикла
begin
  //сначала получим адрес программы:
  adres:= ExtractFilePath(ParamStr(0));
  //настроим сетку:
  SG.Cells[0, 0]:= 'ФИО студента';
  SG.Cells[1, 0]:= 'Дата рождения';
  SG.Cells[2, 0]:= 'Специальность';
  SG.Cells[3, 0]:= 'Форма обучения';
  SG.Cells[4, 0]:= 'Пол';
  SG.ColWidths[0]:= 220;
  SG.ColWidths[1]:= 120;
  SG.ColWidths[2]:= 150;
  SG.ColWidths[3]:= 150;
  SG.ColWidths[4]:= 100;

  //если файла данных нет, просто выходим:
  if not FileExists(adres + 'market.dat') then exit;
  //иначе файл есть, открываем его для чтения и
  //считываем данные в сетку:
  try
    AssignFile(f, adres + 'market.dat');
    Reset(f);
    //теперь цикл - от первой до последней записи сетки:
    while not Eof(f) do begin
      //считываем новую запись:
      Read(f, MyMarket);
      //добавляем в сетку новую строку, и заполняем её:
        SG.RowCount:= SG.RowCount + 1;
        SG.Cells[0, SG.RowCount-1]:= MyMarket.fio;
        SG.Cells[1, SG.RowCount-1] := IntToStr(MyMarket.data);
        SG.Cells[2, SG.RowCount-1] := BoolToStr(MyMarket.Warehouse);
        SG.Cells[3, SG.RowCount-1]:= MyMarket.speciality;
        SG.Cells[4, SG.RowCount-1]:= MyMarket.Pol;
    end;
  finally
    CloseFile(f);
  end;
end;

end.

