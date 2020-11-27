import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../shared_ui_elements/images.dart';

List<Map<String, dynamic>> getAboutData(BuildContext context) {
  return [
    {
      'id': '1',
      'title': S.of(context).noForcedLabor,
      'text': S
          .of(context)
          .actsOfHumanTraffickingInvoluntaryPrisonLabourIndenturedBonded,
      'image': AppImages.principle1Image,
      'logo': AppImages.principle1Logo,
      'color': 0xFFFFAD01,
      'size': 10.0,
      'image_size': 20.0,
    },
    {
      'id': '2',
      'title': S.of(context).noChildLabor,
      'text':
          S.of(context).noPersonShallBeEmployedUnderTheAgeOf15OrUnderTheAgeFor,
      'image': AppImages.principle2Image,
      'logo': AppImages.principle2Logo,
      'color': 0xFFFF7200,
      'size': 10.0,
      'image_size': 17.0,
    },
    {
      'id': '3',
      'title': S.of(context).noDiscrimination,
      'text': S.of(context).noWorkerShallBeSubjectToAnyDiscriminationInAny,
      'image': AppImages.principle3Image,
      'logo': AppImages.principle3Logo,
      'color': 0xFFD43937,
      'size': 8.0,
      'image_size': 15.0,
    },
    {
      'id': '4',
      'title': S.of(context).accessToGrievanceResolutionMechanisms,
      'text': S.of(context).workersMustHaveAccessToEffectiveGrievanceMechanisms,
      'image': AppImages.principle4Image,
      'logo': AppImages.principle4Logo,
      'color': 0xFF9B1514,
      'size': 10.0,
      'image_size': 17.0,
    },
    {
      'id': '5',
      'title': S.of(context).safeAndHealthyWorkplace,
      'text':
          S.of(context).businessesMustProvideASafeAndHealthyWorkplaceAndTake,
      'image': AppImages.principle5Image,
      'logo': AppImages.principle5Logo,
      'color': 0xFFD40055,
      'size': 10.0,
      'image_size': 17.0,
    },
    {
      'id': '6',
      'title': S.of(context).fairPayAndHours,
      'text': S.of(context).workersMustBePaidPromptlyAndFairlyForTheirWork,
      'image': AppImages.principle6Image,
      'logo': AppImages.principle6Logo,
      'color': 0xFF6A133E,
      'size': 10.0,
      'image_size': 15.0,
    },
    {
      'id': '7',
      'title': S.of(context).freedomOfAssociation,
      'text': S
          .of(context)
          .workersShallBeFreeToJoinOrganisationsIncludingUnionsOfTheir,
      'image': AppImages.principle7Image,
      'logo': AppImages.principle7Logo,
      'color': 0xFF0B6FBD,
      'size': 10.0,
      'image_size': 15.0,
    },
    {
      'id': '8',
      'title': S.of(context).appropriateEmploymentRelationsAndWrittenContracts,
      'text': S
          .of(context)
          .allWorkersMustHaveALegallyBindingWrittenContractOfEmployment,
      'image': AppImages.principle8Image,
      'logo': AppImages.principle8Logo,
      'color': 0xFF27ADD2,
      'size': 7.0,
      'image_size': 15.0,
    },
    {
      'id': '9',
      'title': S.of(context).dignityAndRespect,
      'text':
          S.of(context).aBusinessShallEnsureThatItsWorkersAreTreatedWithDignity,
      'image': AppImages.principle9Image,
      'logo': AppImages.principle9Logo,
      'color': 0xFF4AAF13,
      'size': 10.0,
      'image_size': 15.0,
    },
    {
      'id': '10',
      'title': S.of(context).supplyChainTraceabilityAndTransparency,
      'text': S.of(context).businessesMustBeAbleToTraceAndBeTransparentAboutAll,
      'image': AppImages.principle10Image,
      'logo': AppImages.principle10Logo,
      'color': 0xFF0D741F,
      'size': 7.0,
      'image_size': 13.0,
    },
  ];
}
