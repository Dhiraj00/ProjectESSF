// To parse this JSON data, do
//
//     final emergencyModel = emergencyModelFromJson(jsonString);

import 'dart:convert';

EmergencyModel emergencyModelFromJson(String str) => EmergencyModel.fromJson(json.decode(str));

String emergencyModelToJson(EmergencyModel data) => json.encode(data.toJson());

class EmergencyModel {
    EmergencyModel({
        this.meta,
        this.data,
    });

    Meta meta;
    List<List<dynamic>> data;

    factory EmergencyModel.fromJson(Map<String, dynamic> json) => EmergencyModel(
        meta: Meta.fromJson(json["meta"]),
        data: List<List<dynamic>>.from(json["data"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x)))),
    };
}

class Meta {
    Meta({
        this.view,
    });

    View view;

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        view: View.fromJson(json["view"]),
    );

    Map<String, dynamic> toJson() => {
        "view": view.toJson(),
    };
}

class View {
    View({
        this.id,
        this.name,
        this.attribution,
        this.averageRating,
        this.category,
        this.createdAt,
        this.description,
        this.displayType,
        this.downloadCount,
        this.hideFromCatalog,
        this.hideFromDataJson,
        this.indexUpdatedAt,
        this.licenseId,
        this.newBackend,
        this.numberOfComments,
        this.oid,
        this.provenance,
        this.publicationAppendEnabled,
        this.publicationGroup,
        this.publicationStage,
        this.rowClass,
        this.rowsUpdatedAt,
        this.rowsUpdatedBy,
        this.tableId,
        this.totalTimesRated,
        this.viewCount,
        this.viewType,
        this.approvals,
        this.columns,
        this.grants,
        this.license,
        this.metadata,
        this.query,
        this.rights,
        this.tableAuthor,
        this.tags,
        this.flags,
    });

    String id;
    String name;
    String attribution;
    int averageRating;
    String category;
    int createdAt;
    String description;
    String displayType;
    int downloadCount;
    bool hideFromCatalog;
    bool hideFromDataJson;
    int indexUpdatedAt;
    String licenseId;
    bool newBackend;
    int numberOfComments;
    int oid;
    String provenance;
    bool publicationAppendEnabled;
    int publicationGroup;
    String publicationStage;
    String rowClass;
    int rowsUpdatedAt;
    String rowsUpdatedBy;
    int tableId;
    int totalTimesRated;
    int viewCount;
    String viewType;
    List<Approval> approvals;
    List<Column> columns;
    List<Grant> grants;
    License license;
    Metadata metadata;
    Query query;
    List<String> rights;
    TableAuthor tableAuthor;
    List<String> tags;
    List<String> flags;

    factory View.fromJson(Map<String, dynamic> json) => View(
        id: json["id"],
        name: json["name"],
        attribution: json["attribution"],
        averageRating: json["averageRating"],
        category: json["category"],
        createdAt: json["createdAt"],
        description: json["description"],
        displayType: json["displayType"],
        downloadCount: json["downloadCount"],
        hideFromCatalog: json["hideFromCatalog"],
        hideFromDataJson: json["hideFromDataJson"],
        indexUpdatedAt: json["indexUpdatedAt"],
        licenseId: json["licenseId"],
        newBackend: json["newBackend"],
        numberOfComments: json["numberOfComments"],
        oid: json["oid"],
        provenance: json["provenance"],
        publicationAppendEnabled: json["publicationAppendEnabled"],
        publicationGroup: json["publicationGroup"],
        publicationStage: json["publicationStage"],
        rowClass: json["rowClass"],
        rowsUpdatedAt: json["rowsUpdatedAt"],
        rowsUpdatedBy: json["rowsUpdatedBy"],
        tableId: json["tableId"],
        totalTimesRated: json["totalTimesRated"],
        viewCount: json["viewCount"],
        viewType: json["viewType"],
        approvals: List<Approval>.from(json["approvals"].map((x) => Approval.fromJson(x))),
        columns: List<Column>.from(json["columns"].map((x) => Column.fromJson(x))),
        grants: List<Grant>.from(json["grants"].map((x) => Grant.fromJson(x))),
        license: License.fromJson(json["license"]),
        metadata: Metadata.fromJson(json["metadata"]),
        query: Query.fromJson(json["query"]),
        rights: List<String>.from(json["rights"].map((x) => x)),
        tableAuthor: TableAuthor.fromJson(json["tableAuthor"]),
        tags: List<String>.from(json["tags"].map((x) => x)),
        flags: List<String>.from(json["flags"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "attribution": attribution,
        "averageRating": averageRating,
        "category": category,
        "createdAt": createdAt,
        "description": description,
        "displayType": displayType,
        "downloadCount": downloadCount,
        "hideFromCatalog": hideFromCatalog,
        "hideFromDataJson": hideFromDataJson,
        "indexUpdatedAt": indexUpdatedAt,
        "licenseId": licenseId,
        "newBackend": newBackend,
        "numberOfComments": numberOfComments,
        "oid": oid,
        "provenance": provenance,
        "publicationAppendEnabled": publicationAppendEnabled,
        "publicationGroup": publicationGroup,
        "publicationStage": publicationStage,
        "rowClass": rowClass,
        "rowsUpdatedAt": rowsUpdatedAt,
        "rowsUpdatedBy": rowsUpdatedBy,
        "tableId": tableId,
        "totalTimesRated": totalTimesRated,
        "viewCount": viewCount,
        "viewType": viewType,
        "approvals": List<dynamic>.from(approvals.map((x) => x.toJson())),
        "columns": List<dynamic>.from(columns.map((x) => x.toJson())),
        "grants": List<dynamic>.from(grants.map((x) => x.toJson())),
        "license": license.toJson(),
        "metadata": metadata.toJson(),
        "query": query.toJson(),
        "rights": List<dynamic>.from(rights.map((x) => x)),
        "tableAuthor": tableAuthor.toJson(),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "flags": List<dynamic>.from(flags.map((x) => x)),
    };
}

class Approval {
    Approval({
        this.state,
        this.submissionObject,
        this.submissionOutcome,
        this.workflowId,
        this.submissionDetails,
    });

    String state;
    String submissionObject;
    String submissionOutcome;
    int workflowId;
    SubmissionDetails submissionDetails;

    factory Approval.fromJson(Map<String, dynamic> json) => Approval(
        state: json["state"],
        submissionObject: json["submissionObject"],
        submissionOutcome: json["submissionOutcome"],
        workflowId: json["workflowId"],
        submissionDetails: SubmissionDetails.fromJson(json["submissionDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "state": state,
        "submissionObject": submissionObject,
        "submissionOutcome": submissionOutcome,
        "workflowId": workflowId,
        "submissionDetails": submissionDetails.toJson(),
    };
}

class SubmissionDetails {
    SubmissionDetails({
        this.permissionType,
    });

    String permissionType;

    factory SubmissionDetails.fromJson(Map<String, dynamic> json) => SubmissionDetails(
        permissionType: json["permissionType"],
    );

    Map<String, dynamic> toJson() => {
        "permissionType": permissionType,
    };
}

class Column {
    Column({
        this.id,
        this.name,
        this.dataTypeName,
        this.fieldName,
        this.position,
        this.renderTypeName,
        this.format,
        this.flags,
        this.tableColumnId,
        this.width,
        this.subColumnTypes,
    });

    int id;
    String name;
    TypeName dataTypeName;
    String fieldName;
    int position;
    TypeName renderTypeName;
    Query format;
    List<String> flags;
    int tableColumnId;
    int width;
    List<String> subColumnTypes;

    factory Column.fromJson(Map<String, dynamic> json) => Column(
        id: json["id"],
        name: json["name"],
        dataTypeName: typeNameValues.map[json["dataTypeName"]],
        fieldName: json["fieldName"],
        position: json["position"],
        renderTypeName: typeNameValues.map[json["renderTypeName"]],
        format: Query.fromJson(json["format"]),
        flags: json["flags"] == null ? null : List<String>.from(json["flags"].map((x) => x)),
        tableColumnId: json["tableColumnId"] == null ? null : json["tableColumnId"],
        width: json["width"] == null ? null : json["width"],
        subColumnTypes: json["subColumnTypes"] == null ? null : List<String>.from(json["subColumnTypes"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dataTypeName": typeNameValues.reverse[dataTypeName],
        "fieldName": fieldName,
        "position": position,
        "renderTypeName": typeNameValues.reverse[renderTypeName],
        "format": format.toJson(),
        "flags": flags == null ? null : List<dynamic>.from(flags.map((x) => x)),
        "tableColumnId": tableColumnId == null ? null : tableColumnId,
        "width": width == null ? null : width,
        "subColumnTypes": subColumnTypes == null ? null : List<dynamic>.from(subColumnTypes.map((x) => x)),
    };
}

enum TypeName { META_DATA, TEXT, LOCATION }

final typeNameValues = EnumValues({
    "location": TypeName.LOCATION,
    "meta_data": TypeName.META_DATA,
    "text": TypeName.TEXT
});

class Query {
    Query();

    factory Query.fromJson(Map<String, dynamic> json) => Query(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Grant {
    Grant({
        this.inherited,
        this.type,
        this.flags,
    });

    bool inherited;
    String type;
    List<String> flags;

    factory Grant.fromJson(Map<String, dynamic> json) => Grant(
        inherited: json["inherited"],
        type: json["type"],
        flags: List<String>.from(json["flags"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "inherited": inherited,
        "type": type,
        "flags": List<dynamic>.from(flags.map((x) => x)),
    };
}

class License {
    License({
        this.name,
        this.logoUrl,
        this.termsLink,
    });

    String name;
    String logoUrl;
    String termsLink;

    factory License.fromJson(Map<String, dynamic> json) => License(
        name: json["name"],
        logoUrl: json["logoUrl"],
        termsLink: json["termsLink"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "logoUrl": logoUrl,
        "termsLink": termsLink,
    };
}

class Metadata {
    Metadata({
        this.rdfSubject,
        this.rdfClass,
        this.customFields,
        this.sidebar,
        this.rowLabel,
        this.availableDisplayTypes,
        this.renderTypeConfig,
    });

    String rdfSubject;
    String rdfClass;
    CustomFields customFields;
    Sidebar sidebar;
    String rowLabel;
    List<String> availableDisplayTypes;
    RenderTypeConfig renderTypeConfig;

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        rdfSubject: json["rdfSubject"],
        rdfClass: json["rdfClass"],
        customFields: CustomFields.fromJson(json["custom_fields"]),
        sidebar: Sidebar.fromJson(json["sidebar"]),
        rowLabel: json["rowLabel"],
        availableDisplayTypes: List<String>.from(json["availableDisplayTypes"].map((x) => x)),
        renderTypeConfig: RenderTypeConfig.fromJson(json["renderTypeConfig"]),
    );

    Map<String, dynamic> toJson() => {
        "rdfSubject": rdfSubject,
        "rdfClass": rdfClass,
        "custom_fields": customFields.toJson(),
        "sidebar": sidebar.toJson(),
        "rowLabel": rowLabel,
        "availableDisplayTypes": List<dynamic>.from(availableDisplayTypes.map((x) => x)),
        "renderTypeConfig": renderTypeConfig.toJson(),
    };
}

class CustomFields {
    CustomFields({
        this.melbourneMetadata,
        this.dataManagement,
        this.quality,
        this.howToUse,
    });

    MelbourneMetadata melbourneMetadata;
    DataManagement dataManagement;
    Quality quality;
    HowToUse howToUse;

    factory CustomFields.fromJson(Map<String, dynamic> json) => CustomFields(
        melbourneMetadata: MelbourneMetadata.fromJson(json["Melbourne Metadata"]),
        dataManagement: DataManagement.fromJson(json["Data management"]),
        quality: Quality.fromJson(json["Quality"]),
        howToUse: HowToUse.fromJson(json["How to use"]),
    );

    Map<String, dynamic> toJson() => {
        "Melbourne Metadata": melbourneMetadata.toJson(),
        "Data management": dataManagement.toJson(),
        "Quality": quality.toJson(),
        "How to use": howToUse.toJson(),
    };
}

class DataManagement {
    DataManagement({
        this.sourceDataUpdateFrequency,
    });

    String sourceDataUpdateFrequency;

    factory DataManagement.fromJson(Map<String, dynamic> json) => DataManagement(
        sourceDataUpdateFrequency: json["Source data update frequency"],
    );

    Map<String, dynamic> toJson() => {
        "Source data update frequency": sourceDataUpdateFrequency,
    };
}

class HowToUse {
    HowToUse({
        this.furtherInformation,
    });

    String furtherInformation;

    factory HowToUse.fromJson(Map<String, dynamic> json) => HowToUse(
        furtherInformation: json["Further information"],
    );

    Map<String, dynamic> toJson() => {
        "Further information": furtherInformation,
    };
}

class MelbourneMetadata {
    MelbourneMetadata({
        this.furtherInformation,
    });

    String furtherInformation;

    factory MelbourneMetadata.fromJson(Map<String, dynamic> json) => MelbourneMetadata(
        furtherInformation: json["Further Information"],
    );

    Map<String, dynamic> toJson() => {
        "Further Information": furtherInformation,
    };
}

class Quality {
    Quality({
        this.updateFrequency,
        this.dataQualityStatement,
        this.reliabilityLevel,
        this.whatSIncluded,
    });

    String updateFrequency;
    String dataQualityStatement;
    String reliabilityLevel;
    String whatSIncluded;

    factory Quality.fromJson(Map<String, dynamic> json) => Quality(
        updateFrequency: json["Update frequency"],
        dataQualityStatement: json["Data quality statement"],
        reliabilityLevel: json["Reliability level"],
        whatSIncluded: json["What's included"],
    );

    Map<String, dynamic> toJson() => {
        "Update frequency": updateFrequency,
        "Data quality statement": dataQualityStatement,
        "Reliability level": reliabilityLevel,
        "What's included": whatSIncluded,
    };
}

class RenderTypeConfig {
    RenderTypeConfig({
        this.visible,
    });

    Visible visible;

    factory RenderTypeConfig.fromJson(Map<String, dynamic> json) => RenderTypeConfig(
        visible: Visible.fromJson(json["visible"]),
    );

    Map<String, dynamic> toJson() => {
        "visible": visible.toJson(),
    };
}

class Visible {
    Visible({
        this.table,
    });

    bool table;

    factory Visible.fromJson(Map<String, dynamic> json) => Visible(
        table: json["table"],
    );

    Map<String, dynamic> toJson() => {
        "table": table,
    };
}

class Sidebar {
    Sidebar({
        this.width,
    });

    int width;

    factory Sidebar.fromJson(Map<String, dynamic> json) => Sidebar(
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "width": width,
    };
}

class TableAuthor {
    TableAuthor({
        this.id,
        this.displayName,
        this.profileImageUrlLarge,
        this.profileImageUrlMedium,
        this.profileImageUrlSmall,
        this.screenName,
        this.type,
        this.userSegment,
        this.flags,
    });

    String id;
    String displayName;
    String profileImageUrlLarge;
    String profileImageUrlMedium;
    String profileImageUrlSmall;
    String screenName;
    String type;
    String userSegment;
    List<String> flags;

    factory TableAuthor.fromJson(Map<String, dynamic> json) => TableAuthor(
        id: json["id"],
        displayName: json["displayName"],
        profileImageUrlLarge: json["profileImageUrlLarge"],
        profileImageUrlMedium: json["profileImageUrlMedium"],
        profileImageUrlSmall: json["profileImageUrlSmall"],
        screenName: json["screenName"],
        type: json["type"],
        userSegment: json["userSegment"],
        flags: List<String>.from(json["flags"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "displayName": displayName,
        "profileImageUrlLarge": profileImageUrlLarge,
        "profileImageUrlMedium": profileImageUrlMedium,
        "profileImageUrlSmall": profileImageUrlSmall,
        "screenName": screenName,
        "type": type,
        "userSegment": userSegment,
        "flags": List<dynamic>.from(flags.map((x) => x)),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
