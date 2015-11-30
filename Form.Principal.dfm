object Principal: TPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Bate Exist'#234'ncia'
  ClientHeight = 159
  ClientWidth = 413
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblPosicao: TLabel
    Left = 8
    Top = 82
    Width = 274
    Height = 36
    AutoSize = False
    WordWrap = True
  end
  object cmdCarga: TBitBtn
    Left = 288
    Top = 82
    Width = 113
    Height = 25
    Caption = 'Iniciar a carga'
    TabOrder = 0
    OnClick = cmdCargaClick
  end
  object PB: TProgressBar
    Left = 8
    Top = 124
    Width = 393
    Height = 17
    Max = 5
    Step = 1
    TabOrder = 1
  end
  object rgEmpresa: TRadioGroup
    Left = 8
    Top = 8
    Width = 201
    Height = 41
    Caption = 'Empresa'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'FIDC LP'
      'FIDC NP')
    TabOrder = 2
    OnClick = rgEmpresaClick
  end
  object dtpData: TDateTimePicker
    Left = 215
    Top = 28
    Width = 186
    Height = 21
    Date = 42324.728981446760000000
    Time = 42324.728981446760000000
    TabOrder = 3
    OnChange = dtpDataChange
  end
  object txtCaminho: TEdit
    Left = 8
    Top = 55
    Width = 393
    Height = 21
    TabOrder = 4
    Text = 'txtCaminho'
  end
end
