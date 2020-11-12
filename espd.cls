\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{espd}[2019/08/24 GOST 19]
\RequirePackage[utf8]{inputenc}
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

% Создает переменную, задается \cmd{val}, возвращается \@cmd (по умолчанию - пустая строка)
% \var{cmd}
\def\varempty#1{
  \expandafter
  \def\csname #1\endcsname##1{\expandafter\def\csname @#1\endcsname{##1}}
  \expandafter
  \def\csname @#1\endcsname{}
}

% Пишет в AUX файл данную пару ключ-значение
% \set{key}{val}
\def\set#1#2{\write\@auxout{\string\newlabel{#1}{#2}}}

% Получает из AUX файла значение по ключу
% \get{key}
\def\get#1{\csname r@#1\endcsname}

% Получает из AUX файла значение по ключу (по умолчанию 0)
% \get{key}
\def\getnum#1{\ifcsname r@#1\endcsname \csname r@#1\endcsname \else 0 \fi}

% ПЕРЕМЕННЫЕ И КОНСТАНТЫ

% Размеры шрифта
\renewcommand{\normalsize}{\fontsize{12pt}{18pt}\selectfont}
\newcommand{\titlesize}{\fontsize{14pt}{21pt}\selectfont}
\newcommand{\approvalsize}{\fontsize{17pt}{24pt}\selectfont}
\newcommand{\sectionsize}{\fontsize{17pt}{18pt}\selectfont}
\newcommand{\subsectionsize}{\fontsize{14pt}{16pt}\selectfont}
\newcommand{\attachmentsize}{\fontsize{17pt}{24pt}\selectfont}
\newcommand{\tabletextsize}{\fontsize{10pt}{15pt}\selectfont}
\newcommand{\footnotesize}{\fontsize{8pt}{12pt}\selectfont}
\newcommand{\footnotetextsize}{\fontsize{10pt}{15pt}\selectfont}

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
\setlength{\parskip}{2mm}
\setlength{\headheight}{10mm}
\setlength{\headsep}{7.5mm}
\setlength{\arrayrulewidth}{0.1pt}
\newlength{\tabmarg}
\setlength{\tabmarg}{2mm}
\setlength{\tabcolsep}{\tabmarg}
\raggedbottom

% Константы
\def\wordagree{Согласовано}
\def\wordapprove{Утверждаю}
\def\wordopenquote{<<}
\def\wordclosequote{>>}
\def\wordyear{г.}
\def\wordapproval{Лист утверждения}
\def\wordapprovalpostfix{-ЛУ}
\def\wordperformer{Исполнитель}
\def\wordperformers{Исполнители}
\def\wordapproved{Утвержден}
\def\wordsheets{Листов}
\def\wordannotation{Аннотация}
\def\wordterms{Перечень терминов}
\def\wordabbreviations{Перечень сокращений}
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
\def\wordchanged{изменен-ных}
\def\wordreplaced{заменен-ных}
\def\wordnew{новых}
\def\wordannulled{аннули-рованных}
\def\wordimage{Рис.}
\def\wordrefimage{рис.~}
\def\wordbibliography{Перечень использованных источников}

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
\var{countrycode}
\var{organizationcode}
\var{redaction}
\var{documentnumber}
\var{partnumber}
\var{code}
\var{author}
\var{authorrank}
\var{city}
\varempty{authori}
\varempty{authorii}
\varempty{authoriii}
\varempty{authoriv}
\varempty{authorv}
\varempty{authorranki}
\varempty{authorrankii}
\varempty{authorrankiii}
\varempty{authorrankiv}
\varempty{authorrankv}

% Значения переменных по умолчанию
\company{Правительство Российской Федерации\\Национальный исследовательский университет\\<<Высшая школа экономики>>}
\department{Факультет компьютерных наук\\Департамент программной инженерии}
\director{В.В. Шилов}
\directorrank{Академический руководитель\\образовательной программы\\<<Программная инженерия>>\\профессор департамента программной\\инженерии, канд. техн. наук}
\countrycode{RU}
\organizationcode{17701729}
\redaction{01}
\documentnumber{01}
\partnumber{1}

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

% Код документа
\def\fullcode{\@countrycode.\@organizationcode.\@code-\@redaction~\@typecode~\@documentnumber-\@partnumber}

% Код документа с постфиксом листа утверждения
\def\fullcodeapp{\fullcode\wordapprovalpostfix}

% Инициализация параметров
\ProcessOptions*

% МАКРОСЫ ДЛЯ ВНУТРЕННЕГО ИСПОЛЬЗОВАНИЯ

% Вставляет должность и место для подписи для исполнителя
% \titleauthorraw{author}{authorrank}
\def\titleauthorraw#1#2{
  \vskip 1mm #2\\\rule{4cm}{0.1pt}/#1/\\\wordopenquote\rule{8mm}{0.1pt}\wordclosequote~\rule{4cm}{0.1pt} \@year~\wordyear\\
}

% То же, но делает проверку на пустоту строк
% \titleauthor{author}{authorrank}
\def\titleauthor#1#2{
  \if&#1#2&\else%
    \titleauthorraw{#1}{#2}
  \fi
}

% Модификация перевода строки для использования \centering и \MakeUppercase
% \protectlinebreak
\def\protectlinebreak{
  \let\defaultlinebreak\\
  \renewcommand{\\}{\protect\defaultlinebreak}
}

% Вставляет приложение без нумерации
% \writeattachmentnotnum{description}{title}{label}
\def\writeattachmentnonum#1#2#3{
  \refstepcounter{attachment}
  \hfill{\textbf{\MakeUppercase{\wordattachment}}}\vspace{-4mm} \\
  \null\hfill #1 \\
  {
    \attachmentsize\bfseries\centering#2\par
  }
  \addcontentsline{toc}{attachment}{\wordattachment.~#2}
  \ifx&#3&\else
    \label{#3}
  \fi
}

% Вставляет приложение с нумерацией
% \writeattachmentnum{description}{title}{label}
\def\writeattachmentnum#1#2#3{
  \refstepcounter{attachment}
  \hfill{\textbf{\MakeUppercase{\wordattachment~\theattachment}}}\vspace{-4mm} \\
  \null\hfill #1 \\
  {
    \attachmentsize\bfseries\centering#2\par
  }
  \addcontentsline{toc}{attachment}{\wordattachment~\theattachment.~#2}
  \ifx&#3&\else
    \label{#3}
  \fi
}

% Вставляет приложение
% \attachment{description}{title}[label]
\def\attachment#1#2{
  \@ifnextchar[
    {\attachment@i{#1}{#2}}
    {\attachment@i{#1}{#2}[]}
}

\def\attachment@i#1#2[#3]{
  \newpage
  \ifnum\getnum{lastattachment}=1
    \writeattachmentnonum{#1}{#2}{#3}
  \else
    \writeattachmentnum{#1}{#2}{#3}
  \fi
}

% Создает ячейку заданных размеров с центрованным текстом внутри
% \def{width}{height}{text}
\def\cell#1#2#3{
  \parbox[c][#2][c]{#1}{\centering #3}%
}

% Создает ячейку с центрованным текстом внутри с настраиваемой реальной высотой
% \def{width}{height}{realheight}{text}
\def\vcell#1#2#3#4{\parbox[c][#3][b]{#1}{\vbox to #2{\cell{#1}{#2}{#4}\vss}}}

\def\writesection#1{
  \newpage
  \begin{center}
    \centering\sectionsize\bfseries\MakeUppercase{#1}
  \end{center}
  \par
}

\def\writesubsection#1{
  \begingroup
  \par
  \parindent -1cm
  \leftskip 2cm
  \interlinepenalty\@M
  \vspace{4mm}
  {\subsectionsize\bfseries#1}%
  \vspace{2mm}
  \par
  \endgroup
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
\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thesubsection}{\arabic{section}.\arabic{subsection}}
\renewcommand{\theparagraph}{\arabic{section}.\arabic{subsection}.\arabic{paragraph}}
\renewcommand{\thesubparagraph}{\arabic{section}.\arabic{subsection}.\arabic{paragraph}.\arabic{subparagraph}}
\renewcommand{\theattachment}{\arabic{attachment}}
\newcommand{\numsection}{\thesection.}
\newcommand{\numsubsection}{\thesubsection.}
\newcommand{\numparagraph}{\theparagraph.}
\newcommand{\numsubparagraph}{\thesubparagraph.}
\newcommand{\section}[1]{
  \ifx&#1&
    \ClassError
      {espd}
      {Empty section title}
      {According to GOST 19.106-78, section title can not be empty}
  \fi
  \refstepcounter{section}
  \writesection{\numsection~#1}
  \addcontentsline{toc}{section}{\numsection~#1}
}
\newcommand{\subsection}[1]{
  \ifx&#1&
    \ClassError
      {espd}
      {Empty subsection title}
      {According to GOST 19.106-78, subsection title can not be empty}
  \fi
  \refstepcounter{subsection}
  \writesubsection{\numsubsection~#1}
  \addcontentsline{toc}{subsection}{\numsubsection~#1}
}
\newcommand{\paragraph}[1]{
  \refstepcounter{paragraph}
  \writesubsection{\numparagraph~#1}
  \ifx&#1&\else
    \addcontentsline{toc}{paragraph}{\numparagraph~#1}
  \fi
}
\newcommand{\subparagraph}[1]{
  \refstepcounter{subparagraph}
  \writesubsection{\numsubparagraph~#1}
  \ifx&#1&\else
    \addcontentsline{toc}{subparagraph}{\numsubparagraph~#1}
  \fi
}

% Аннотация
\newcommand{\annotation}{\writesection{\wordannotation}}

% Перечень терминов
\newenvironment{terms}
{
  \writesection{\wordterms}
  \addcontentsline{toc}{attachment}{\wordterms}
}
{
}
\newcommand{\term}[2]{\textbf{#1} -- #2. \par}

% Перечень сокращений
\newenvironment{abbreviations}
{
  \writesection{\wordabbreviations}
  \addcontentsline{toc}{attachment}{\wordabbreviations}
}
{
}

% Лист регистрации изменений
\newcommand{\registration}{
  \newpage
  \tabletextsize
  \renewcommand{\baselinestretch}{0.6}\selectfont
  \setlength{\tabcolsep}{0mm}
  \hbox{%
    \begin{tabular}{|c|c|c|c|c|c|c|c|c|c|}
      \hline
      \multicolumn{10}{|c|}{\cell{185mm}{10mm}{\normalsize \wordregistration}} \\
      \hline
      \multicolumn{5}{|c|}{\cell{88mm}{6mm}{\wordsheetnumber}} & & & & & \\
      \cline{1-5}
      \cell{8mm}{19mm}{\wordchanges} & \cell{20mm}{19mm}{\wordchanged} & \cell{20mm}{19mm}{\wordreplaced} & \cell{20mm}{19mm}{\wordnew} & \cell{20mm}{19mm}{\wordannulled} & \vcell{20mm}{25mm}{19mm}{\wordsheetsindoc} & \vcell{25mm}{25mm}{19mm}{\worddocnumber} & \vcell{25mm}{25mm}{19mm}{\wordincldocanddate} & \vcell{15mm}{25mm}{19mm}{\wordsign} & \vcell{12mm}{25mm}{19mm}{\worddate} \\
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
  \setlength{\tabcolsep}{\tabmarg}
}

% Штамп для учета
\newcommand{\record}{
  \tabletextsize
  \setlength{\tabcolsep}{0mm}
  \itshape
  \begin{tabular}{|p{25mm}|p{35mm}|p{25mm}|p{25mm}|p{35mm}|}
    \hline
    \cell{25mm}{5mm}{\wordoriginvnumber} & \cell{35mm}{5mm}{\wordsignanddate} & \cell{25mm}{5mm}{\wordinstinvnumber} & \cell{25mm}{5mm}{\wordduplinvnumber} & \cell{35mm}{5mm}{\wordsignanddate} \\
    \hline
    \cell{25mm}{7mm}{} & & & & \\
    \hline
  \end{tabular}%
  \setlength{\tabcolsep}{\tabmarg}
}

% Окружение для страниц информационной части
\newenvironment{titlepage}
{
  \thispagestyle{empty}
  \setcounter{page}{0}
  \setlength{\tabcolsep}{0mm}
  \renewcommand{\baselinestretch}{0.8}\selectfont
}
{
  \newpage
  \setlength{\tabcolsep}{\tabmarg}
  \renewcommand{\baselinestretch}{1}\selectfont
}

% Лист утверждения
\newcommand{\makeapproval}{
\begin{titlepage}
  \reversemarginpar
  \setlength{\marginparsep}{12mm}
  \marginpar{\vskip 11.5cm \hbox{\rotatebox{90}{\record}}}
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
  \vskip \fill
  \begin{tabular}{c c}
    \makebox[0.5\textwidth]{} & \parbox[t]{0.5\textwidth}{\centering\if&\@authori\@authorii\@authoriii\@authoriv\@authorv\@authorranki\@authorrankii\@authorrankiii\@authorrankiv\@authorrankv&
      \wordperformer\\\titleauthor{\@author}{\@authorrank}
    \else
      \wordperformers\\\titleauthor{\@authori}{\@authorranki}\titleauthor{\@authorii}{\@authorrankii}\titleauthor{\@authoriii}{\@authorrankiii}\titleauthor{\@authoriv}{\@authorrankiv}\titleauthor{\@authorv}{\@authorrankv}\fi}
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
  \marginpar{\vskip 11.5cm \hbox{\rotatebox{90}{\record}}}
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
  \textbf{\wordsheets~\getnum{lastpage}}
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
  \writesection{\wordcontents}
  \@starttoc{toc}
}
\newcommand\l@section[1]{\@dottedtocline{1}{0cm}{0.5cm}{\textbf{#1}}}
\newcommand\l@subsection{\@dottedtocline{2}{0.5cm}{1cm}}
\newcommand\l@paragraph{\@dottedtocline{3}{1cm}{1.5cm}}
\newcommand\l@subparagraph{\@dottedtocline{4}{1.5cm}{2cm}}
\newcommand\l@attachment{\@dottedtocline{1}{0cm}{3cm}}

% ВСТАВЛЯЕМЫЙ КОНТЕНТ

% Иллюстрация
% \illustration[title][description][scale]{file}[label]
\def\illustration{
  \@ifnextchar[
    {\illustration@i}
    {\illustration@i[]}
}

\def\illustration@i[#1]{
  \@ifnextchar[
    {\illustration@ii[#1]}
    {\illustration@ii[#1][]}
}

\def\illustration@ii[#1][#2]{
  \@ifnextchar[
    {\illustration@iii[#1][#2]}
    {\illustration@iii[#1][#2][0.8]}
}

\def\illustration@iii[#1][#2][#3]#4{
  \@ifnextchar[
    {\illustration@iv[#1][#2][#3]#4}
    {\illustration@iv[#1][#2][#3]#4[]}
}

\def\illustration@iv[#1][#2][#3]#4[#5]{
  \refstepcounter{illustration}
  \vspace{6mm}
  \begin{center}
    \ifx&#1&\else
      #1 \nopagebreak \\
    \fi
    \vspace{4mm}
    \includegraphics[width=#3\textwidth]{#4} \nopagebreak
    \ifx&#2&\else
      \\\vspace{4mm}
      \parbox{#3\textwidth}{\centering#2} \nopagebreak
    \fi
    \\\vspace{4mm}
    \ifnum\getnum{lastillustration}=1
    \else
      \wordimage~\arabic{illustration}.
    \fi
    \ifx&#5&\else
      \label{#5}
    \fi
  \end{center}
  \vspace{6mm}
  \par
}
\newcounter{illustration}
\renewcommand{\theillustration}{\wordrefimage\arabic{illustration}}

% Картинка
% \image[scale]{file}
\newcommand{\image}[2][1]{
  \vspace{6mm}
  \begin{center}
    \includegraphics[width=#1\textwidth]{#2}
  \end{center}
  \vspace{6mm}
  \par
}

% РАЗНОЕ

% Сноски
\renewcommand{\footnoterule}{\rule{3cm}{0.1pt}\vskip 2mm}
\def\@makefnmark{\@textsuperscript{\footnotesize\@thefnmark)}}
\def\@makefntext#1{\hskip 1cm\@makefnmark\footnotetextsize#1}

% Перечисления
\def\theenumi{\arabic{enumi}}
\def\p@enumi{\theenumi}
\def\labelenumi{\theenumi)}
\setlength{\labelsep}{5mm}
\setlength{\labelwidth}{-\parindent}
\addtolength{\labelwidth}{-\labelsep}
\addtolength{\labelwidth}{-4mm}

% Библиография
\def\url{\texttt}
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\def\@biblabel#1{#1.}
\newenvironment{thebibliography}[1]
{
  \writesection{\wordbibliography}
  \list{\@biblabel{\@arabic\c@enumiv}}
    {\settowidth\labelwidth{\@biblabel{#1}}
     \leftmargin\labelwidth
     \advance\leftmargin\labelsep
     \usecounter{enumiv}
     \let\p@enumiv\@empty
     \renewcommand\theenumiv{\@arabic\c@enumiv}}
}
{
  \endlist
  \addcontentsline{toc}{attachment}{\wordbibliography}
}

% Вставка листа утверждения и титульного листа
\AtBeginDocument{\makeapproval\maketitle}

% Вставка листа о регистрации изменений и указателей на последние элементы
\AtEndDocument{
  \registration
  \set{lastpage}{\thepage}
  \set{lastattachment}{\arabic{attachment}}
  \set{lastillustration}{\arabic{illustration}}
}

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
