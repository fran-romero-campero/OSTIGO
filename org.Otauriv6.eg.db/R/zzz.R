datacache <- new.env(hash=TRUE, parent=emptyenv())

org.Otauriv6.eg <- function() showQCData("org.Otauriv6.eg", datacache)
org.Otauriv6.eg_dbconn <- function() dbconn(datacache)
org.Otauriv6.eg_dbfile <- function() dbfile(datacache)
org.Otauriv6.eg_dbschema <- function(file="", show.indices=FALSE) dbschema(datacache, file=file, show.indices=show.indices)
org.Otauriv6.eg_dbInfo <- function() dbInfo(datacache)

org.Otauriv6.egORGANISM <- "Ostreococcus tauriv6"

.onLoad <- function(libname, pkgname)
{
    ## Connect to the SQLite DB
    dbfile <- system.file("extdata", "org.Otauriv6.eg.sqlite", package=pkgname, lib.loc=libname)
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
        
    packageStartupMessage(AnnotationDbi:::annoStartupMessages("org.Otauriv6.eg.db"))
}

.onUnload <- function(libpath)
{
    dbFileDisconnect(org.Otauriv6.eg_dbconn())
}

