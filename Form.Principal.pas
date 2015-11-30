unit Form.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, AR.ActiveRecord, BE.Conexao, Vcl.ComCtrls,
  Vcl.ExtCtrls;

type
  TPrincipal = class(TForm)
    cmdCarga: TBitBtn;
    PB: TProgressBar;
    rgEmpresa: TRadioGroup;
    dtpData: TDateTimePicker;
    txtCaminho: TEdit;
    lblPosicao: TLabel;
    procedure cmdCargaClick(Sender: TObject);
    procedure rgEmpresaClick(Sender: TObject);
    procedure dtpDataChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function CarregaScript(const AArquivo: string): string;
    procedure MudouValores;
  public
  end;

var
  Principal: TPrincipal;

implementation

{$R *.dfm}

procedure TPrincipal.cmdCargaClick(Sender: TObject);
const
  LCodigoEmpresa: array [Boolean] of Integer = (2, 3);
var
  LConexao: IActiveRecordConnection;
  LCodigo: Integer;
begin
  LCodigo := LCodigoEmpresa[rgEmpresa.ItemIndex = 1];
  cmdCarga.Enabled := False;
  Screen.Cursor := crHourGlass;
  try
    lblPosicao.Caption := 'Abrindo conexão com o banco';
    LConexao := CriaConexao_BE;
    PB.StepIt;
    lblPosicao.Caption := 'Carregando a existência';
    Application.ProcessMessages;
    LConexao.ExecuteAndReturnRecordsAffected(Format('exec petra.CarregaExistencia %d, ''%s''',
      [LCodigo, txtCaminho.Text]));
    PB.StepIt;
    lblPosicao.Caption := 'Conciliando cheques';
    Application.ProcessMessages;
    LConexao.ExecuteAndReturnRecordsAffected(Format(CarregaScript('ConciliaCheques'), [LCodigo]));
    PB.StepIt;
    lblPosicao.Caption := 'Conciliando duplicatas com valor (atual) e Sacado';
    Application.ProcessMessages;
    LConexao.ExecuteAndReturnRecordsAffected(Format(CarregaScript('ConciliaDuplicatas1'), [LCodigo]));
    PB.StepIt;
    lblPosicao.Caption := 'Conciliando duplicatas com valor (original) e Sacado (apenas idg de compra)';
    Application.ProcessMessages;
    LConexao.ExecuteAndReturnRecordsAffected(Format(CarregaScript('ConciliaDuplicatas2'), [LCodigo]));
    PB.StepIt;
    lblPosicao.Caption := 'Ajustando recebíveis recomprados';
    Application.ProcessMessages;
    LConexao.ExecuteAndReturnRecordsAffected(Format(CarregaScript('AjustaRecompra'), [LCodigo]));
    PB.StepIt;
    lblPosicao.Caption := 'Ajustando recebíveis liquidados parcialmente';
    Application.ProcessMessages;
    LConexao.ExecuteAndReturnRecordsAffected(Format(CarregaScript('AjustaParcial'), [LCodigo]));
  finally
    Screen.Cursor := crDefault;
    lblPosicao.Caption := '';
    PB.Position := 0;
    cmdCarga.Enabled := True;
  end;
end;

function TPrincipal.CarregaScript(const AArquivo: string): string;
var
  LArquivo: TStringList;
begin
  LArquivo := TStringList.Create;
  try
    LArquivo.LoadFromFile(IncludeTrailingPathDelimiter(ExtractFilePath(GetModuleName(HInstance))) + 'SQLs\' + AArquivo
      + '.sql');
    Result := LArquivo.Text;
  finally
    LArquivo.Free;
  end;
end;

procedure TPrincipal.dtpDataChange(Sender: TObject);
begin
  MudouValores;
end;

procedure TPrincipal.FormCreate(Sender: TObject);
var
  LData: TDateTime;
begin
  LData := Date - 1;
  while DayOfWeek(LData) in [1, 7] do
    LData := LData - 1;
  dtpData.Time := 0;
  dtpData.Date := LData;
  MudouValores;
end;

procedure TPrincipal.MudouValores;
const
  SufixoAno: array [Boolean] of string = ('', '"-NP"');
  MeioArquivo: array [Boolean] of string = ('CREDT', 'CDTNP');
begin
  txtCaminho.Text := FormatDateTime('yyyy' + SufixoAno[rgEmpresa.ItemIndex = 1] + '\mm\"ExistenciaPetra' +
    MeioArquivo[rgEmpresa.ItemIndex = 1] + '"yyyymmdd"R.csv"', dtpData.Date);
end;

procedure TPrincipal.rgEmpresaClick(Sender: TObject);
begin
  MudouValores;
end;

end.
