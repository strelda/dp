(* ::Package:: *)

(* ::Section:: *)
(*Inicialize some functions*)


(* ::Input:: *)
(*<<CompiledFunctionTools`;*)
(*<<MaTeX`;*)
(*Needs["NumericalCalculus`"]*)
(*ParallelNeeds["NumericalCalculus`"]*)
(*compileOptions={CompilationTarget->"C",RuntimeOptions->{"EvaluateSymbolically"->False,"CatchMachineUnderflow"->False,"CatchMachineOverflow"->False}};*)
(*compileOptionsPar={Parallelization->True,RuntimeAttributes->{Listable},RuntimeOptions->"Speed"};*)
(*font={BaseStyle->Directive[FontSize->12],AxesStyle->Directive[FontSize->12],TicksStyle->Directive[FontSize->12],LabelStyle->{FontFamily->"Latin Modern Roman",FontSize-> 12},BaseStyle->texStyle};*)
(*densityPlotOptions={PlotRange->Full,PlotLegends->Automatic,FrameLabel->MaTeX/@{"\\lambda","\\chi"},Evaluate@font,ColorFunction->"SunsetColors"};*)


(* ::Section:: *)
(*First order perturbation Hamiltonian*)


(* ::Input:: *)
(*$Assumptions={\[Lambda]\[Element]Reals,\[Chi]\[Element]Reals};*)


(* ::Input:: *)
(*\[Delta][a_,b_]:=KroneckerDelta[a,b];*)
(*Je[sn_,j_,m_]:=Sqrt[j(j+1)-m(m+sn 1)];*)


(* ::Input:: *)
(*V1[jp_,mp_,j_,m_]:=1/4 (Je[1,j,m+1]Je[1,j,m]\[Delta][mp,m+2]+Je[-1,j,m-1]Je[-1,j,m]\[Delta][mp,m-2]+\[Delta][mp,m](Je[-1,j,m]Je[1,j,m-1]+Je[1,j,m]Je[-1,j,m+1] ))*)
(*V2[jp_,mp_,j_,m_]:=1/2 (m+j)(Je[1,j,m]\[Delta][mp,m+1]+Je[-1,j,m]\[Delta][mp,m-1])+1/2 (m+1+j)Je[1,j,m]\[Delta][mp,m+1]+1/2 (m-1+j)Je[-1,j,m]\[Delta][mp,m-1]*)
(*V3[jp_,mp_,j_,m_]:=\[Delta][mp,m](j+m)^2*)
(*Hd[jp_,mp_,j_,m_]:=m \[Delta][jp,j]\[Delta][mp,m]-\[Delta][jp,j]/(2j) (\[Lambda] V1[jp,mp,j,m]+\[Chi] V2[jp,mp,j,m]+\[Chi]^2 V3[jp,mp,j,m])*)


(* ::Input:: *)
(*nn=10;*)
(*jj=nn/2; *)
(*dim=nn+1;*)
(*f[mp_,m_]:=Hd[jj,mp,jj,m];*)
(*HH=Table[f[mp,m],{mp,-jj,jj},{m,-jj,jj}];*)
(*H[\[Lambda]_,\[Chi]_]=Table[f[mp,m],{mp,-jj,jj},{m,-jj,jj}];*)
(*HC=Compile[{{\[Lambda],_Real},{\[Chi],_Real}},Evaluate@HH,Evaluate@compileOptions];*)


(* ::Input:: *)
(*If[ConjugateTranspose@H[2,7]==H[2,7],Print["Probably is Hermitean"],Print["THIS IS NOT Hermitean"]]*)
(*H[\[Lambda],\[Chi]]//MatrixForm//FullSimplify*)


(* ::Input:: *)
(*DH1[\[Lambda]_,\[Chi]_]=D[H[\[Lambda],\[Chi]],\[Lambda]];*)
(*DH2[\[Lambda]_,\[Chi]_]=D[H[\[Lambda],\[Chi]],\[Chi]];*)
(*g[\[Lambda]_,\[Chi]_]:=Module[{g11,g12,g22,energies,eigenvectors},*)
(*energies=Eigenvalues[H[\[Lambda],\[Chi]]];*)
(*eigenvectors=Map[Normalize,Eigenvectors[H[\[Lambda],\[Chi]]]];*)
(*g11=Re@Sum[((Conjugate[eigenvectors[[1]]].DH1[\[Lambda],\[Chi]].eigenvectors[[i]])(Conjugate[eigenvectors[[i]]].DH1[\[Lambda],\[Chi]].eigenvectors[[1]]))/(energies[[1]]-energies[[i]])^2,{i,2,dim}];*)
(*g12=Re@Sum[(Conjugate[eigenvectors[[1]]].DH1[\[Lambda],\[Chi]].eigenvectors[[i]]Conjugate[eigenvectors[[i]]].DH2[\[Lambda],\[Chi]].eigenvectors[[1]])/(energies[[1]]-energies[[i]])^2,{i,2,dim}];*)
(*g22=Re@Sum[((Conjugate[eigenvectors[[1]]].DH2[\[Lambda],\[Chi]].eigenvectors[[i]])(Conjugate[eigenvectors[[i]]].DH2[\[Lambda],\[Chi]].eigenvectors[[1]]))/(energies[[1]]-energies[[i]])^2,{i,2,dim}];*)
(*{{g11,g12},{g12,g22}}*)
(*]*)


(* ::Input:: *)
(*DH1C=Compile[{{\[Lambda],_Real},{\[Chi],_Real}},Evaluate@D[H[\[Lambda],\[Chi]],\[Lambda]],Evaluate@compileOptions];*)
(*DH2C=Compile[{{\[Lambda],_Real},{\[Chi],_Real}},Evaluate@D[H[\[Lambda],\[Chi]],\[Chi]],Evaluate@compileOptions];*)
(*gC[\[Lambda]_?NumericQ,\[Chi]_?NumericQ]:=Module[{enNonSort,en,eigNonSort,eig,g11,g12,g22,M1,M1T,M2,M2T,endif},*)
(*{enNonSort,eigNonSort}=Eigensystem[HC[\[Lambda],\[Chi]],Method->{"Banded"}];*)
(*{en,eig}=Transpose@SortBy[Transpose[{enNonSort,eigNonSort}],First];*)
(*M1=Conjugate[eig[[1]]].DH1C[\[Lambda],\[Chi]].eig[[#]]&/@Range[2,dim];*)
(*M1T=Conjugate[eig[[#]]].DH1C[\[Lambda],\[Chi]].eig[[1]]&/@Range[2,dim];*)
(**)
(*M2=Conjugate[eig[[1]]].DH2C[\[Lambda],\[Chi]].eig[[#]]&/@Range[2,dim];*)
(*M2T=Conjugate[eig[[#]]].DH2C[\[Lambda],\[Chi]].eig[[1]]&/@Range[2,dim];*)
(*endif=(en[[1]]-en[[#]])^2&/@Range[2,dim];*)
(*g11=Re@Sum[(M1[[i]]M1T[[i]])/endif[[i]],{i,1,dim-1}];*)
(*g12=Re@Sum[(M1[[i]]M2T[[i]])/endif[[i]],{i,1,dim-1}];*)
(*g22=Re@Sum[(M2[[i]]M2T[[i]])/endif[[i]],{i,1,dim-1}];*)
(*{{g11,g12},{g12,g22}}*)
(*]*)
