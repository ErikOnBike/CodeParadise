Extension { #name : #CpDownloader }

{ #category : #'*CodeParadise-Browser-Support' }
CpDownloader class >> blob: aBlob filename: filenameString [

	"Download the specified blob content using the given filename"

	CpDomElement globalApply: #cpDownload withArguments: { aBlob . aBlob type . filenameString }
]
