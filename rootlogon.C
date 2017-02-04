// This is the file rootlogon.C                                                 
{
  printf("Loading MyStyle ... \n");

  TStyle *myStyle  = new TStyle("MyStyle","My Root Styles");

  // from ROOT plain style

  myStyle->SetTitleFillColor(0) ; 
  myStyle->SetTitleBorderSize(0); 

  myStyle->SetCanvasBorderMode(0);
  myStyle->SetPadBorderMode(0);
  myStyle->SetPadColor(0);
  myStyle->SetCanvasColor(0);
  myStyle->SetTitleColor(0);
  myStyle->SetStatColor(0);
  myStyle->SetPalette(1);
  myStyle->SetLabelSize(0.025,"xyz"); // size of axis values
  // myStyle->SetTitleOffset(1.2, "Y");  
  // myStyle->SetTitleOffset(1.2, "X");  

  // default canvas positioning
  
  myStyle->SetCanvasDefX(900);
  myStyle->SetCanvasDefY(20);
  myStyle->SetCanvasDefH(550);
  myStyle->SetCanvasDefW(540);
  myStyle->SetPadBottomMargin(0.1);
  myStyle->SetPadTopMargin(0.1);
  myStyle->SetPadLeftMargin(0.125);
  myStyle->SetPadRightMargin(0.05);

  // myStyle->SetPadTickX(1);
  // myStyle->SetPadTickY(1);

  myStyle->SetFrameBorderMode(0);

  myStyle->SetStatColor(0); 
  myStyle->SetStatBorderSize(1); 

  gROOT->SetStyle("MyStyle"); 
}
