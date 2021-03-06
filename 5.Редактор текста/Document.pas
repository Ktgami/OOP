unit Document;

interface

uses StdCtrls, ComCtrls, Controls, Dialogs, LastFileController, Book, MainForm, SysUtils;

type

TDocument=class(TTabSheet)
  private
    Memo : TMemo;
    FullName : string;
    OpenDlg : TOpenDialog;
    SaveDlg : TSaveDialog;
    FileLast:TLastFileController;
    procedure SetDocName(S : string);
    function GetDocName : string;
    procedure CorrectCaption;
    public
    constructor Create(AOwner: TWinControl; FileLast:TLastFileController);
    destructor Destroy; override;
    property Name : string read GetDocName write SetDocName;
    procedure Open;
    function Save:string;
    function SaveAs:string;
    procedure OpenFrom(path:string);
end;

implementation

 constructor TDocument.Create(AOwner: TWinControl; FileLast: TLastFileController);
   begin
     inherited Create(AOwner);
     Memo := TMemo.Create(self);
     Memo.Parent := self;
     Memo.Align := alClient;
     OpenDlg := TOpenDialog.Create(self);
     SaveDlg := TSaveDialog.Create(self);
     FullName := '';
     self.FileLast := FileLast;
    end;

 destructor TDocument.Destroy;
   begin
     if Memo.Modified then
      if MessageDlg('File not saved. Save now?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then Save;
     inherited Destroy;
   end;

 procedure TDocument.SetDocName(S : string);
   begin
     Caption := S;
   end;

 function TDocument.GetDocName : string;
   begin
     GetDocName := Caption;
   end;

 function TDocument.Save: string ;
  begin
    if FullName <> '' then
     begin
       Memo.Lines.SaveToFile(FullName);
       Memo.Modified := false;
     end
    else SaveAs;
  end;

 procedure TDocument.CorrectCaption;
  var S : string;
      i : integer;
   begin
     S := '';
     i := length(FullName);
     while (i>0) and (FullName[i] <> '\') do
       begin
         S := FullName[i] + S;
         dec(i);
       end;
     Caption := S;
   end;

 function TDocument.SaveAs: string ;
var old:string;
   begin
     if SaveDlg.Execute then
       begin
         old:=FullName;
         FullName := SaveDlg.FileName;
         Caption := FullName;
         CorrectCaption;
         Memo.Lines.SaveToFile(FullName);
         Memo.Modified := false;
         FileLast.AddItem(FullName);
         Result:=FullName;
       end;
   end;

 procedure TDocument.Open;
   begin
     if OpenDlg.Execute then
       begin
         FullName := OpenDlg.FileName;
         CorrectCaption;
         if FileExists(FullName) then  begin
          Memo.Lines.LoadFromFile(FullName);
          FileLast.AddItem(FullName);
         end; end;
 end;

   procedure TDocument.OpenFrom(path:string );
   begin
     if path <> '' then
       begin
         FullName := path;
         CorrectCaption;
         if FileExists(FullName) then begin
          Memo.Lines.LoadFromFile(FullName);
          //Form1.Book.FileLast.AddItem(FullName);
          end;
       end
     else Free;
   end;

end.
