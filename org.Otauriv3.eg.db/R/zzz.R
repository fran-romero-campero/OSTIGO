datacache <- new.env(hash=TRUE, parent=emptyenv())

org.Otauriv3.eg <- function() showQCData("org.Otauriv3.eg", datacache)
org.Otauriv3.eg_dbconn <- function() dbconn(datacache)
org.Otauriv3.eg_dbfile <- function() dbfile(datacache)
org.Otauriv3.eg_dbschema <- function(file="", show.indices=FALSE) dbschema(datacache, file=file, show.indices=show.indices)
org.Otauriv3.eg_dbInfo <- function() dbInfo(datacache)

org.Otauriv3.egORGANISM <- "Ostreococcus tauriv3"

.onLoad <- function(libname, pkgname)
{
    ## Connect to the SQLite DB
    dbfile <- system.file("extdata", "org.Otauriv3.eg.sqlite", package=pkgname, lib.loc=libname)
    assign("dbfile", dbfile, envir=datacache)
    dbconn <- dbFileConnect(dbfile)
    assign("dbconn", dbconn, envir=datacache)

    ## Create the OrgDb object
    sPkgname <- sub(".db$","",pkgname)
    db <- loadDb(system.file("extdata", paste(sPkgname,
      ".sqlite",sep=""), package=pkgname, lib.loc=libname),
                   packageName=pkgname)    
    dbNewname <- AnnotationDbi:::dbObjectName(pkgname,"OrgDb")
    ns <- asNamespace(pkgname)
    assign(dbNewname, db, envir=ns)
    namespaceExport(ns, dbNewname)
        
    packageStartupMessage(AnnotationDbi:::annoStartupMessages("org.Otauriv3.eg.db"))
}

.onUnload <- function(libpath)
{
    dbFileDisconnect(org.Otauriv3.eg_dbconn())
}

