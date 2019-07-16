\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{espd}[2019/07/15 GOST 19]
\RequirePackage[T2A]{fontenc}
\RequirePackage{graphicx}

% Создает переменную, задается \cmd{val}, возвращается \@cmd
% \var{cmd}
\def\var#1{
  \expandafter
  \def\csname #1\endcsname##1{
    \ifx&##1&
      \ClassError
        {espd}
        {The \@backslashchar#1 cannot be empty}
        {You should specify non-empty #1 by typing \@backslashchar#1{#1 name}}
    \fi
    \expandafter\def\csname @#1\endcsname{##1}}
  \expandafter
  \def\csname @#1\endcsname{
    \ClassError
      {espd}
      {No \@backslashchar#1 given}
      {You should specify #1 by typing \@backslashchar#1{#1 name} in the preamble}}
}

% ПЕРЕМЕННЫЕ И КОНСТАНТЫ

% Размеры шрифта
\renewcommand{\normalsize}{\fontsize{12pt}{18pt}\selectfont}
\newcommand{\titlesize}{\fontsize{14pt}{21pt}\selectfont}
\newcommand{\approvalsize}{\fontsize{16pt}{24pt}\selectfont}
\newcommand{\sectionsize}{\fontsize{20pt}{30pt}\selectfont}
\newcommand{\subsectionsize}{\fontsize{18pt}{27pt}\selectfont}
\newcommand{\attachmentsize}{\fontsize{18pt}{27pt}\selectfont}
\newcommand{\tabletextsize}{\fontsize{10pt}{15pt}\selectfont}

% Бумага
\setlength{\paperwidth}{210mm}
\setlength{\paperheight}{297mm}
\setlength{\pdfpagewidth}{\paperwidth}
\setlength{\pdfpageheight}{\paperheight}

% Отступы и размеры
\setlength{\hoffset}{-25.4mm}
\setlength{\voffset}{-25.4mm}
\setlength{\oddsidemargin}{20mm}
\setlength{\topmargin}{7.5mm}
\setlength{\textwidth}{180mm}
\setlength{\textheight}{257mm}
\setlength{\parindent}{10mm}
\setlength{\parskip}{1mm}
\setlength{\headheight}{10mm}
\setlength{\headsep}{7.5mm}
\setlength{\footskip}{0mm}
\setlength{\arrayrulewidth}{0.1pt}
\def\@seccntformat#1{\csname the#1\endcsname\hspace{1ex}}

\DeclareOption{techtask}{
  \type{Техническое задание}
  \typecode{ТЗ}
}
\DeclareOption{listing}{
  \type{Текст программы}
  \typecode{12}
}
\DeclareOption{progmanual}{
  \type{Руководство программиста}
  \typecode{33}
}
\DeclareOption{opermanual}{
  \type{Руководство оператора}
  \typecode{34}
}
\DeclareOption{langdesc}{
  \type{Описание языка}
  \typecode{35}
}
\DeclareOption{testmethods}{
  \type{Программа и методика испытаний}
  \typecode{51}
}
\DeclareOption{explnote}{
  \type{Пояснительная записка}
  \typecode{81}
}

% Константы
\def\wordagree{Согласовано}
\def\wordapprove{Утверждаю}
\def\wordopenquote{<<}
\def\wordclosequote{>>}
\def\wordyear{г.}
\def\wordapproval{Лист утверждения}
\def\wordapprovalpostfix{-ЛУ}
\def\wordperformer{Исполнитель}
\def\wordapproved{Утвержден}
\def\wordsheets{Листов}
\def\wordannotation{Аннотация}
\def\wordcontents{Содержание}
\def\wordattachment{Приложение}
\def\wordoriginvnumber{Инв. \textnumero~подл.}
\def\wordsignanddate{\wordsign и дата}
\def\wordinstinvnumber{Взам. инв. \textnumero}
\def\wordduplinvnumber{Инв. \textnumero~дубл.}
\def\wordregistration{Лист регистрации изменений}
\def\wordsheetnumber{Номера листов (страниц)}
\def\wordsheetsindoc{Всего листов (страниц) в докум.}
\def\worddocnumber{\textnumero\\документа}
\def\wordincldocanddate{Входящий \textnumero~сопрово-дительного докум. и дата}
\def\wordsign{Подп.}
\def\worddate{Дата}
\def\wordchanges{Изм.}
\def\wordchanged{Изменен-ных}
\def\wordreplaced{Заменен-ных}
\def\wordnew{Новых}
\def\wordannulled{Аннули-рованных}

% Переменные
\var{company}
\var{department}
\var{manager}
\var{managerrank}
\var{director}
\var{directorrank}
\var{year}
\var{title}
\var{type}
\var{typecode}
\var{documentnumber}
\var{partnumber}
\var{code}
\var{author}
\var{authorrank}
\var{city}

% Значения переменных по умолчанию
\documentnumber{01}
\partnumber{1}

% Код документа
\def\fullcode{\@code~\@typecode~\@documentnumber-\@partnumber}

% Код документа с постфиксом листа утверждения
\def\fullcodeapp{\fullcode\wordapprovalpostfix}

% Инициализация параметров
\ProcessOptions*

% МАКРОСЫ ДЛЯ ВНУТРЕННЕГО ИСПОЛЬЗОВАНИЯ

% Переопределенный макрос, не добавляет строку в содержание, если строка пуста. Напрямую не используется
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \ifx#7\@empty \else
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}%
    \fi
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \ifx#7\@empty \else
        \addcontentsline{toc}{#1}{%
          \ifnum #2>\c@secnumdepth \else
            \protect\numberline{\csname the#1\endcsname}%
          \fi
          #7}}%
      \fi
  \fi
  \@xsect{#5}}

% Модификация перевода строки для использования \centering и \MakeUppercase
% \protectlinebreak
\def\protectlinebreak{
  \let\defaultlinebreak\\
  \renewcommand{\\}{\protect\defaultlinebreak}
}

% Вставляет приложение без нумерации
% \writeattachmentnotnum{description}{title}
\def\writeattachmentnonum#1#2{
  \refstepcounter{attachment}
  \hfill{\textbf{\MakeUppercase{\wordattachment}}}\vspace{-4mm} \\
  \null\hfill #1 \\
  {
    \attachmentsize\bfseries\centering\MakeUppercase{#2}\par
  }
  \addcontentsline{toc}{attachment}{\MakeUppercase{\numberline{\wordattachment.}}#2}
  \label{lastattachment}
}

% Вставляет приложение с нумерацией
% \writeattachmentnum{description}{title}
\def\writeattachmentnum#1#2{
  \refstepcounter{attachment}
  \hfill{\textbf{\MakeUppercase{\wordattachment~\theattachment}}}\vspace{-4mm} \\
  \null\hfill #1 \\
  {
    \attachmentsize\bfseries\centering\MakeUppercase{#2}\par
  }
  \addcontentsline{toc}{attachment}{\MakeUppercase{\numberline{\wordattachment~\theattachment.}}#2}
  \label{lastattachment}
}

% Упрощение макроса \@setref
\def\@setrefnum#1#2#3{\expandafter#2#1}
% Возвращает номер ссылки
% \refnum{label}
\def\refnum#1{\expandafter\@setrefnum\csname r@#1\endcsname\@firstoftwo{#1}}

% Вставляет приложение
% \attachment{description}{title}
\newcommand{\attachment}[2]{
  \newpage
  \if1\refnum{lastattachment}
    \writeattachmentnonum{#1}{#2}
  \else
    \writeattachmentnum{#1}{#2}
  \fi
}

% Создает ячейку заданных размеров с центрованным текстом внутри
% \def{width}{height}{text}
\def\cell#1#2#3{
  \parbox[c][#2][c]{#1}{\centering #3}%
}

% Создает ячейку с центрованным текстом внутри с настраиваемой реальной высотой
% \def{width}{height}{realheight}{text}
\def\vcell#1#2#3#4{
  \vbox to #2{\hbox{\parbox[c][#3][c]{#1}{\centering #4}}\vss}%
}

% СЕКЦИОНИРОВАНИЕ

% Счетчики
\setcounter{secnumdepth}{4}
\newcounter{section}
\newcounter{subsection}[section]
\newcounter{paragraph}[subsection]
\newcounter{subparagraph}[paragraph]
\newcounter{attachment}

% Разделы, подразделы, пункты и подпункты
\renewcommand{\thesection}{\arabic{section}.}
\renewcommand{\thesubsection}{\arabic{section}.\arabic{subsection}.}
\renewcommand{\theparagraph}{\arabic{section}.\arabic{subsection}.\arabic{paragraph}.}
\renewcommand{\thesubparagraph}{\arabic{section}.\arabic{subsection}.\arabic{paragraph}.\arabic{subparagraph}.}
\renewcommand{\theattachment}{\arabic{attachment}}
\newcommand{\section}{\newpage\@startsection{section}{1}{0mm}{\z@}{0.1pt}{\centering\sectionsize\bfseries\MakeUppercase}}
\newcommand{\subsection}{\@startsection{subsection}{2}{8mm}{\z@}{0.1pt}{\subsectionsize\bfseries}}
\newcommand{\paragraph}{\@startsection{paragraph}{3}{4mm}{\z@}{0.1pt}{\subsectionsize\bfseries}}
\newcommand{\subparagraph}{\@startsection{subparagraph}{4}{4mm}{\z@}{0.1pt}{\subsectionsize\bfseries}}

% Аннотация
\newcommand{\annotation}{\newpage{\centering\sectionsize\bfseries\MakeUppercase{\wordannotation}\par}}

% Лист регистрации изменений
\newcommand{\registration}{
  \newpage
  \tabletextsize
  \renewcommand{\baselinestretch}{0.6}\selectfont
  \hbox{
  \noindent
    \begin{tabular}{|c|c|c|c|c|c|c|c|c|c|}
      \hline
      \multicolumn{10}{|c|}{\cell{185mm}{10mm}{\normalsize \wordregistration}} \\
      \hline
      \multicolumn{5}{|c|}{\cell{88mm}{6mm}{\wordsheetnumber}} & \vcell{20mm}{6mm}{25mm}{\wordsheetsindoc} & \vcell{25mm}{6mm}{25mm}{\worddocnumber} & \vcell{25mm}{6mm}{25mm}{\wordincldocanddate} & \vcell{15mm}{6mm}{25mm}{\wordsign} & \vcell{12mm}{6mm}{25mm}{\worddate} \\
      \cline{1-5}
      \cell{8mm}{19mm}{\wordchanges} & \cell{20mm}{19mm}{\wordchanged} & \cell{20mm}{19mm}{\wordreplaced} & \cell{20mm}{19mm}{\wordnew} & \cell{20mm}{19mm}{\wordannulled} & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
      \cell{8mm}{8mm}{} & & & & & & & & & \\
      \hline
    \end{tabular}
  }
}

% Штамп для учета
\newcommand{\record}{
  \tabletextsize
  \itshape
  \begin{tabular}{|p{25mm}|p{35mm}|p{25mm}|p{25mm}|p{35mm}|}
    \hline
    \cell{25mm}{5mm}{\wordoriginvnumber} & \cell{35mm}{5mm}{\wordsignanddate} & \cell{25mm}{5mm}{\wordinstinvnumber} & \cell{25mm}{5mm}{\wordduplinvnumber} & \cell{35mm}{5mm}{\wordsignanddate} \\
    \hline
    \cell{25mm}{7mm}{} & & & & \\
    \hline
  \end{tabular}%
}

% Окружение для страниц информационной части
\newenvironment{titlepage}
{
  \thispagestyle{empty}
  \setcounter{page}{0}
  \renewcommand{\baselinestretch}{0.8}\selectfont
}
{
  \newpage
  \renewcommand{\baselinestretch}{1}\selectfont
}

% Лист утверждения
\newcommand{\makeapproval}{
\begin{titlepage}
  \reversemarginpar
  \setlength{\marginparsep}{12mm}
  \marginpar{\vskip 11cm \hbox{\rotatebox{90}{\record}}}
  \vskip -\baselineskip
  \centering
  \protectlinebreak
  \textbf{\MakeUppercase{\@company}}
  \vskip 0.5cm
  \@department
  \vskip 1cm
  \begin{tabular}{c c}
    \parbox[t][4cm]{0.5\textwidth}{\centering\MakeUppercase{\wordagree}\\\@managerrank} &
    \parbox[t][4cm]{0.5\textwidth}{\centering\MakeUppercase{\wordapprove}\\\@directorrank} \\
    \rule{4cm}{0.1pt}~\@manager &
    \rule{4cm}{0.1pt}~\@director \\
    \wordopenquote\rule{8mm}{0.1pt}\wordclosequote~\rule{3cm}{0.1pt} \@year~\wordyear &
    \wordopenquote\rule{8mm}{0.1pt}\wordclosequote~\rule{3cm}{0.1pt} \@year~\wordyear
  \end{tabular}
  \vskip 1cm
  \titlesize\textbf{\MakeUppercase{\@title}}
  \vskip 4mm
  \normalsize\textbf{\@type}
  \vskip 4mm
  \approvalsize\textbf{\MakeUppercase{\wordapproval}}
  \vskip 4mm
  \normalsize\textbf{\fullcodeapp}
  \vskip 3cm
  \begin{tabular}{c c}
    \makebox[0.5\textwidth]{} & \parbox[t]{0.5\textwidth}{\centering\wordperformer\\\@authorrank\\\rule{4cm}{0.1pt}/\@author/\\\wordopenquote\rule{8mm}{0.1pt}\wordclosequote~\rule{4cm}{0.1pt} \@year~\wordyear}
  \end{tabular}
  \vskip \fill
  \@city~\@year
  \vskip 5mm
\end{titlepage}
}

% Титульный лист
\newcommand{\maketitle}{
\begin{titlepage}
  \reversemarginpar
  \setlength{\marginparsep}{12mm}
  \marginpar{\vskip 11cm \hbox{\rotatebox{90}{\record}}}
  \vskip -\baselineskip
  \parbox[t]{0.4\textwidth}{\centering\MakeUppercase{\wordapproved}\\\fullcodeapp}
  \vskip 8cm
  \centering
  \protectlinebreak
  \titlesize\textbf{\MakeUppercase{\@title}}
  \vskip 4mm
  \normalsize\textbf{\@type}
  \vskip 4mm
  \textbf{\fullcode}
  \vskip 4mm
  \textbf{\wordsheets~\pageref{lastpage}}
  \vskip \fill
  \@city~\@year
  \vskip 5mm
\end{titlepage}
\stepcounter{page}
}

% Содержание
\newcommand\@pnumwidth{1em}
\newcommand\@tocrmarg{4em}
\newcommand\@dotsep{4}
\setcounter{tocdepth}{4}
\newcommand\tableofcontents{
  \newpage
  \section*{\wordcontents}
  \@starttoc{toc}
}
\newcommand\l@section{\@dottedtocline{1}{0cm}{0.5cm}}
\newcommand\l@subsection{\@dottedtocline{2}{0.5cm}{1cm}}
\newcommand\l@paragraph{\@dottedtocline{3}{1cm}{1.5cm}}
\newcommand\l@subparagraph{\@dottedtocline{4}{1.5cm}{2cm}}
\newcommand\l@attachment{\@dottedtocline{1}{0cm}{4cm}}

% РАЗНОЕ

\newcommand{\illustration}[2][0.8]{
  \begin{center}
    \includegraphics[width=#1\textwidth]{#2}
  \end{center}
  \par
}

% Вставка листа утверждения и титульного листа
\AtBeginDocument{\makeapproval\maketitle}
% Вставка листа о регистрации изменений и указателя на последнюю страницу
\AtEndDocument{\registration\label{lastpage}}

% Колонтитулы и нумерация
\def\ps@default{
  \def\@oddhead{%
    \hfil
    \vbox{
      \hbox to \textwidth{\hfil\thepage\hfil}
      \vspace{2mm}
      \hbox to \textwidth{\hfil\fullcode\hfil}}%
    \hfil
    }
  \let\@oddfoot\@empty
  \let\@evenhead\@oddhead
  \let\@evenfoot\@oddfoot
}
\pagestyle{default}
\pagenumbering{arabic}