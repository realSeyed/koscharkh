import '../../features/destinations/domain/destination.dart';
import '../../features/locations/domain/coordinates.dart';
import '../../features/profile/domain/profile.dart';

const seedDescription =
    'hello this is a test description for this item and i want fill it with anything.';

const seedProfile = Profile(firstName: 'realseyed', lastName: '', age: '');

const seedDestinationTemplates = [
  DestinationDraft(
    stableId: 'dest-1',
    name: 'First Destination',
    description: 'First Charkh',
    coordinates: Coordinates(latitude: 40.7247, longitude: -73.9970),
  ),
  DestinationDraft(
    stableId: 'dest-2',
    name: 'Second Destination',
    description: 'Second Charkh',
    coordinates: Coordinates(latitude: 40.7270, longitude: -73.9995),
  ),
  DestinationDraft(
    stableId: 'dest-3',
    name: 'Third Destination',
    description: 'Third Charkh',
    coordinates: Coordinates(latitude: 40.7304, longitude: -74.0022),
  ),
  DestinationDraft(
    stableId: 'dest-4',
    name: 'Fourth Destination',
    description: 'Fourth Charkh',
    coordinates: Coordinates(latitude: 40.7315, longitude: -73.9942),
  ),
];
