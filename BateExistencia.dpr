program BateExistencia;

uses
  FastMM4 in 'Core\FastMM4.pas',
  FastMM4Messages in 'Core\FastMM4Messages.pas',
  Vcl.Forms,
  Core.ArrayClass in 'Core\Core.ArrayClass.pas',
  Core.ArrayIntf in 'Core\Core.ArrayIntf.pas',
  Core.CacheCod in 'Core\Core.CacheCod.pas',
  Core.CMC7 in 'Core\Core.CMC7.pas',
  Core.ConfiguracoesRegionais in 'Core\Core.ConfiguracoesRegionais.pas',
  Core.CsvStrings in 'Core\Core.CsvStrings.pas',
  Core.GlobalMetodos in 'Core\Core.GlobalMetodos.pas',
  Core.Json in 'Core\Core.Json.pas',
  Core.Metodos in 'Core\Core.Metodos.pas',
  Core.ServiceLocator in 'Core\Core.ServiceLocator.pas',
  Core.Singleton in 'Core\Core.Singleton.pas',
  Core.StringToGUID in 'Core\Core.StringToGUID.pas',
  Core.Tipos in 'Core\Core.Tipos.pas',
  MVC.Iniciadores in 'MVC\MVC.Iniciadores.pas',
  BE.Conexao in 'Outros\BE.Conexao.pas',
  BE.Configuracao in 'Outros\BE.Configuracao.pas',
  AR.ActiveRecord in 'ActiveRecord\AR.ActiveRecord.pas',
  Form.Principal in 'Form.Principal.pas' {Principal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Iniciadores.Iniciar;
  Application.CreateForm(TPrincipal, Principal);
  Application.Run;
  Iniciadores.Finalizar;
end.
