import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../shared_ui_elements/images.dart';

List<Map<String, String>> getAboutData(BuildContext context) {
  return [
    {
      'id': '1',
      'title': S
          .of(context)
          .noForcedLabor,
      'text': S
          .of(context)
          .actsOfHumanTraffickingInvoluntaryPrisonLabourIndenturedBonded,
      'image': AppImages.principle1Image,
      'logo': AppImages.principle1Logo
    },
    {
      'id': '2',
      'title': S
          .of(context)
          .noChildLabor,
      'text': S
          .of(context)
          .noPersonShallBeEmployedUnderTheAgeOf15OrUnderTheAgeFor,
      'image': AppImages.principle2Image,
      'logo': AppImages.principle2Logo
    },
    {
      'id': '3',
      'title': S
          .of(context)
          .noDiscrimination,
      'text': S
          .of(context)
          .noWorkerShallBeSubjectToAnyDiscriminationInAny,
      'image': AppImages.principle3Image,
      'logo': AppImages.principle3Logo
    },
    {
      'id': '4',
      'title': S
          .of(context)
          .accessToGrievanceResolutionMechanisms,
      'text':
      S
          .of(context)
          .workersMustHaveAccessToEffectiveGrievanceMechanisms,
      'image': AppImages.principle4Image,
      'logo': AppImages.principle4Logo
    },
    {
      'id': '5',
      'title': S
          .of(context)
          .safeAndHealthyWorkplace,
      'text':
      S
          .of(context)
          .businessesMustProvideASafeAndHealthyWorkplaceAndTake,
      'image': AppImages.principle5Image,
      'logo': AppImages.principle5Logo
    },
    {
      'id': '6',
      'title': S
          .of(context)
          .fairPayAndHours,
      'text': S
          .of(context)
          .workersMustBePaidPromptlyAndFairlyForTheirWork,
      'image': AppImages.principle6Image,
      'logo': AppImages.principle6Logo
    },
    {
      'id': '7',
      'title': S
          .of(context)
          .freedomOfAssociation,
      'text': S
          .of(context)
          .workersShallBeFreeToJoinOrganisationsIncludingUnionsOfTheir,
      'image': AppImages.principle7Image,
      'logo': AppImages.principle7Logo
    },
    {
      'id': '8',
      'title':
      S
          .of(context)
          .appropriateEmploymentRelationsAndWrittenContracts,
      'text': S
          .of(context)
          .allWorkersMustHaveALegallyBindingWrittenContractOfEmployment,
      'image': AppImages.principle8Image,
      'logo': AppImages.principle8Logo
    },
    {
      'id': '9',
      'title': S
          .of(context)
          .dignityAndRespect,
      'text': S
          .of(context)
          .aBusinessShallEnsureThatItsWorkersAreTreatedWithDignity,
      'image': AppImages.principle9Image,
      'logo': AppImages.principle9Logo
    },
    {
      'id': '10',
      'title': S
          .of(context)
          .supplyChainTraceabilityAndTransparency,
      'text':
      S
          .of(context)
          .businessesMustBeAbleToTraceAndBeTransparentAboutAll,
      'image': AppImages.principle10Image,
      'logo': AppImages.principle10Logo
    },
  ];
}
