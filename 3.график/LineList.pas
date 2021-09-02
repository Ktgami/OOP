unit LineList;

interface
  uses classes, Line, scaler, Contnrs, Graphics, SysUtils;
  type
    TLineList = class(TObjectList)
    private
      FId : integer;
      function GetLine(id: integer):TLine;
    public
      scaler: TScaler;
      constructor Create(_scaler: TScaler);
      function AddLine(x, y: array of real):integer;
      function DelLine(id: integer):boolean;
      procedure Plot(canvas:TCanvas);
      property Lines[id: integer]: TLine read GetLine;
      destructor Destroy;
    end;
implementation
  { TLineList }

  constructor TLineList.Create(_scaler: TScaler);
  begin
    inherited Create;
    FId := 0;
    scaler := _scaler;
  end;

  function TLineList.AddLine(x, y: array of real): integer;
    var newLine : TLine;
    var blackColor : TColor;
  begin

    blackColor := clBlack;

    inc(FId);
    NewLine := TLine.Create(x, y, scaler,FId);

    NewLine.Color := blackColor + 100 * (NewLine.id-1);

    NewLine.Caption := IntToStr(NewLine.id);
    Add(NewLine);

    Result := newLine.Id;
  end;

  function TLineList.DelLine(id: integer): boolean;
  begin
    Remove(GetLine(id));
    Result := true;
    
  end;

  function TLineList.GetLine(id: integer): TLine;
    var L : TLine;
        i : integer;
  begin
    for i := 0 to count-1 do
    begin
      L := Items[i] as TLine;
      if ID = L.ID then
      begin
        result := L;
        exit;
      end;
    end;
  end;

  procedure TLineList.Plot(canvas: TCanvas);
  var
    i: integer;
    curLine : TLine;
  begin
    scaler.FixClipRect(Canvas);
    i := FindInstanceOf(TLine,true,0);
    while i > -1 do
    begin
      curLine := (Items[i] as TLine);
      if curLine <> nil then
        curLine.Plot(canvas);
      i := FindInstanceOf(TLine,true,i+1)     ;
    end;
    scaler.ReleaseClipRect(Canvas);
  end;

  destructor TLineList.Destroy;
  begin
    //inherited;
  end;
end.
