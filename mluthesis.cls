%! Class = mluthesis
%! Author = Fachschaftsrat Mathematik/Informatik der Studierendenschaft der Martin-Luther-Universität Halle-Wittenberg
%! Date = 2020/04/20
% Based on the webisthesis class by the Webis group: https://git.webis.de/code-generic/code-webis-thesis
% Credit: Johannes Kiesel (Bauhaus-Universität Weimar), Peter Prettenhofer (LMU München), Stefan Brecheisen (LMU München)

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mluthesis}[2020/04/20 v1.0]

% Load base class (scrbook).
\LoadClass[a4paper,12pt,oneside,bibliography=totoc,chapterprefix=true,appendixprefix=true]{scrbook}

% Encoding:
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

% Basic utilities:
\RequirePackage{ifpdf}
\RequirePackage{xifthen}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Options
\newcommand{\thesistype}{}
\DeclareOption{bachelor}{%
\renewcommand{\thesistype}{Bachelor}%
}
\DeclareOption{master}{%
\renewcommand{\thesistype}{Master}%
}
\ExecuteOptions{bachelor} % default

\ProcessOptions

% Font
\RequirePackage{libertine}
\RequirePackage{sourcecodepro}
\RequirePackage{eulervm}
\newcommand{\thesistitlefont}{\sffamily}
\addtokomafont{title}{\thesistitlefont\Huge}
\addtokomafont{disposition}{\rmfamily}
\addtokomafont{chapter}{\sffamily}
\addtokomafont{chapterprefix}{\LARGE}
\renewcommand{\autodot}{} % Remove all end-of-counter dots.

% Language
\RequirePackage{babel}
\RequirePackage{iflang}
\newcommand{\IfGerman}[2]{\IfLanguagePatterns{german}{#1}{\IfLanguagePatterns{ngerman}{#1}{#2}}}

% Datetime
\RequirePackage[useregional]{datetime2}
\newcommand{\formatdate}[3]{\DTMDisplaydate{#1}{#2}{#3}{-1}}
\newcommand{\formatdateshort}[3]{%
  \let\tmpDTMgermanmonthname\DTMgermanmonthname%
  \let\tmpDTMenglishmonthname\DTMenglishmonthname%
  \def\DTMgermanmonthname##1{%
    \ifcase##1%
    \or Jan.\or Feb.\or März\or Apr.\or Mai\or Juni%
    \or Juli\or Aug.\or Sep.\or Okt.\or Nov.\or Dez.\fi%
  }%
  \def\DTMenglishmonthname##1{%
    \ifcase##1%
    \or Jan.\or Feb.\or Mar.\or Apr.\or May\or Jun.%
    \or Jul.\or Aug.\or Sep.\or Oct.\or Nov.\or Dec.\fi%
  }%
  \DTMDisplaydate{#1}{#2}{#3}{-1}%
  \let\DTMenglishmonthname\tmpDTMenglishmonthname%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables
\newtoks\thesistitle
\newcommand{\ThesisSetTitle}[1]{\global\thesistitle{#1}}

\newtoks\thesisauthor
\newcommand{\ThesisSetAuthor}[1]{\global\thesisauthor{#1}}

\newtoks\thesissupervisors
\newcommand{\ThesisSetSupervisors}[1]{\global\thesissupervisors{#1}}

\newtoks\thesissubmissiondate
\newcommand{\ThesisSetSubmissionDate}[3]{\global\thesissubmissiondate{\formatdate{#1}{#2}{#3}}}

\newtoks\thesislocation
\newcommand{\ThesisSetLocation}[1]{\global\thesislocation{#1}}

\newtoks\thesisauthorstudentnumber
\newcommand{\ThesisSetStudentNumber}[1]{\global\thesisauthorstudentnumber{#1}}

\newtoks\thesisauthordateofbirth
\newcommand{\ThesisSetDateOfBirth}[3]{\global\thesisauthordateofbirth{\formatdateshort{#1}{#2}{#3}}}

\newtoks\thesisauthorplaceofbirth
\newcommand{\ThesisSetPlaceOfBirth}[1]{\global\thesisauthorplaceofbirth{#1}}

\newtoks\thesiskeywords % Optional
\newcommand{\ThesisSetKeywords}[1]{\global\thesiskeywords{#1}}

\newtoks\thesisuniversity
\newcommand{\ThesisSetUniversity}[1]{\global\thesisuniversity{#1}}

\newtoks\thesisfaculty
\newcommand{\ThesisSetFaculty}[1]{\global\thesisfaculty{#1}}

\newtoks\thesiscoursename
\newcommand{\ThesisSetCourseName}[1]{\global\thesiscoursename{#1}}

\newtoks\thesislogo % Optional
\newcommand{\ThesisSetLogo}[1]{\global\thesislogo{#1}}

% Check if variables are set
% \checkthesisvariable{variable value}{name}{setter command}{example}
\newcommand{\checkthesisvariable}[4]{%
  \ifthenelse{\equal{#1}{}}{\ClassError{webisthesis}{%
    #2 was not defined.\MessageBreak Use command \protect#3{#4} in your preamble}%
  }{}%
}
\newcommand{\checkthesisvariabledate}[3]{%
  \ifthenelse{\equal{#1}{}}{\ClassError{webisthesis}{%
    #2 was not defined.\MessageBreak Use command \protect#3{2022}{12}{31} in your preamble}%
  }{}%
}
% Checking all variables...
\newcommand{\checkthesisvariables}{%
  \checkthesisvariable{\the\thesistitle}{Title}{\ThesisSetTitle}{Title of my Thesis}%
  \checkthesisvariable{\the\thesisauthor}{Author}{\ThesisSetAuthor}{John Smith}%
  \checkthesisvariable{\the\thesissupervisors}{Supervisors}{\ThesisSetSupervisors}{{Prof.~Dr
  .~Jane Doe},{Eddie Blow,~M.Sc.}}%
  \checkthesisvariabledate{\the\thesissubmissiondate}{Submission date}{\ThesisSetSubmissionDate}%
  \checkthesisvariable{\the\thesislocation}{Location}{\ThesisSetLocation}{Halle (Saale)}%
  \checkthesisvariable{\the\thesisauthorstudentnumber}{Student
  number}{\ThesisSetStudentNumber}{01234}%
  \checkthesisvariabledate{\the\thesisauthordateofbirth}{Author's date of
  birth}{\ThesisSetDateOfBirth}%
  \checkthesisvariable{\the\thesisauthorplaceofbirth}{Author's place of
  birth}{\ThesisSetPlaceOfBirth}{Berlin}%
  \checkthesisvariable{\the\thesisuniversity}{University}{\ThesisSetUniversity}{Martin Luther
  University Halle-Wittenberg}%
  \checkthesisvariable{\the\thesisfaculty}{Faculty}{\ThesisSetFaculty}{Faculty of Computer Science}%
  \checkthesisvariable{\the\thesiscoursename}{Course name}{\ThesisSetCourseName}{Computer Science}%
}
% ... at the begin of the document
\AtBeginDocument{\checkthesisvariables}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Template words
\newtoks\thesisfrontpagecourse
\newtoks\thesisfrontpagetypename
\newtoks\thesisfrontpagestudentnumber
\newtoks\thesisfrontpageborn
\newtoks\thesisfrontpagesupervisor
\newtoks\thesisfrontpagedateofsubmission
\newtoks\thesisdeclarationtitle
\newtoks\thesisdeclarationtext
\newtoks\thesisfrontmatterkeywords
\global\thesisfrontpagecourse{Degree Programme }
\global\thesisfrontpagetypename{\thesistype's Thesis}
\global\thesisfrontpagestudentnumber{Matriculation Number}
\global\thesisfrontpageborn{Born \the\thesisauthordateofbirth{} in \the\thesisauthorplaceofbirth}
\global\thesisfrontpagesupervisor{Referee}
\global\thesisfrontpagedateofsubmission{Submission date}
\global\thesisdeclarationtitle{Declaration}
\global\thesisdeclarationtext{%
  I hereby confirm that this thesis %
  is entirely my own original work, without contributions from any sources %
  other than those specified.%
}
\global\thesisfrontmatterkeywords{Keywords}
\IfGerman{%
  \global\thesisfrontpagecourse{Studiengang }
  \global\thesisfrontpagetypename{\thesistype arbeit}
  \global\thesisfrontpagestudentnumber{Matrikelnummer}
  \global\thesisfrontpageborn{geb.\ am:\ \the\thesisauthordateofbirth{} in %
    \the\thesisauthorplaceofbirth}
  \global\thesisfrontpagesupervisor{Gutachter}
  \global\thesisfrontpagedateofsubmission{Datum der Abgabe}
  \global\thesisdeclarationtitle{Erkl\"arung}
  \global\thesisdeclarationtext{Hiermit versichere ich, dass ich diese Arbeit %
  selbstst\"andig verfasst und keine anderen als die angegebenen Quellen und %
  Hilfsmittel verwendet habe.}
  \global\thesisfrontmatterkeywords{Schl\"usselworte}
}{}

% Frontpage
\newcounter{supervisors}
\newcommand{\printsupervisor}[1]{%
  \ifthenelse{\value{supervisors}=0}{}{\\}%
  \addtocounter{supervisors}{1}%
  \arabic{supervisors}. \the\thesisfrontpagesupervisor:
  #1
}
\renewcommand{\maketitle}{
  \begin{titlepage}
    \setlength{\parindent}{0cm}
    \thesistitlefont
    \ifthenelse{\isempty{\the\thesislogo}}{}{
      \the\thesislogo\\[3em]
    }
    \the\thesisuniversity\\
    \the\thesisfaculty\\
    \the\thesisfrontpagecourse\the\thesiscoursename

  \vspace{\fill}

  \begin{center}
    \usekomafont{title}
    \the\thesistitle\\[1em]
    \the\thesisfrontpagetypename
  \end{center}

  \vspace{\fill}

  \the\thesisauthor\\
  \the\thesisfrontpageborn\\
  \the\thesisfrontpagestudentnumber~\the\thesisauthorstudentnumber

  \vspace{1em}
  \makeatletter%
  \@for \name:=\the\thesissupervisors\do{\printsupervisor{\name}}%
  \makeatother%

  \vspace{1em}
  \the\thesisfrontpagedateofsubmission: \the\thesissubmissiondate
\end{titlepage}
}%

\RequirePackage{enumitem}

% Declaration of independent work
\newcommand{\declaration}{
\begin{titlepage}
  \chapter*{\the\thesisdeclarationtitle}
  \setlength{\parindent}{0cm}
  \vspace{1cm}

  \large \the\thesisdeclarationtext
  \vspace{1cm}

  \the\thesislocation, \the\thesissubmissiondate
  \vspace{2cm}

  \makebox[10cm]{\hrulefill}\\
  \the\thesisauthor
\end{titlepage}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Page layout
\RequirePackage{geometry}
\geometry{body={140mm,210mm},footskip=12mm}

\RequirePackage{scrlayer-scrpage}
\pagestyle{scrheadings}
\automark[section]{chapter}
\chead{}
\ihead{\headmark}
\cfoot*{\pagemark}
\setkomafont{pageheadfoot}{\sffamily\slshape}
\setkomafont{pagenumber}{\upshape}

% Enumerate subsections and include them in the table of contents
\setcounter{secnumdepth}{2}
\setcounter{tocdepth}{2}

% Appendices
\RequirePackage[titletoc]{appendix}

% Specification of figure/table caption style
\RequirePackage[font=small,labelfont=bf]{caption}

% Pass default options to hyperref class, if loaded.
\newcommand{\hyperoptions}{
  colorlinks=false,
  pageanchor=false
}
\newcommand{\hyperpdfoptions}{
  pdftex,
  pdfborder={0 0 0},
  pdfauthor={\the\thesisauthor},
  pdftitle={\the\thesistitle},
  pdfkeywords={\the\thesiskeywords},
  pdfdisplaydoctitle,
  pdfpagemode={UseNone},
  pdfstartview={Fit}
}
\ifpdf
\PassOptionsToPackage{\hyperoptions,\hyperpdfoptions}{hyperref}
\else
\PassOptionsToPackage{\hyperoptions}{hyperref}
\fi
