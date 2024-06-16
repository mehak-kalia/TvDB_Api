import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();

  List<String> languages = [
    'eng','aar', 'abk', 'afr', 'aka', 'amh', 'ara', 'arg', 'asm', 'ava', 'ave',
    'aym', 'aze', 'bak', 'bam', 'ban', 'baq', 'bel', 'ben', 'bho', 'bis',
    'bos', 'bre', 'bul', 'bur', 'cat', 'ces', 'cha', 'che', 'chr', 'cym',
    'dan', 'deu', 'div', 'dzo', 'ell',  'epo', 'est', 'ewe', 'fao',
    'fij', 'fin', 'fra', 'fry', 'gla', 'glg', 'grn', 'guj', 'hat', 'hau',
    'heb', 'her', 'hin', 'hrv', 'hun', 'hye', 'ikan', 'ind', 'isl', 'ita',
    'jpn', 'jvn', 'kaq', 'kat', 'kaz', 'khm', 'kik', 'kin', 'kir', 'kom',
    'kon', 'kor', 'koy', 'kur', 'lat', 'lav', 'lim', 'lin', 'lit', 'lub',
    'mac', 'mkd', 'mlg', 'mlt', 'mon', 'msa', 'myv', 'nep', 'nob', 'nso',
    'pan', 'pol', 'por', 'pus', 'que', 'roh', 'ron', 'run', 'rus', 'sag',
    'san', 'sin', 'slo', 'slv', 'smo', 'sna', 'snd', 'som', 'sot', 'spa',
    'swa', 'swe', 'tam', 'tel', 'tgk', 'tha', 'tir', 'tuk', 'uig', 'ukr',
    'urd', 'uzb', 'vie', 'vol', 'wln', 'xho', 'yid', 'yor', 'zha', 'zul'
  ];

  final List<String> countryIds = [
    'ind','abw', 'afg', 'ago', 'aia', 'ala', 'alb', 'and', 'are', 'arg', 'arm',
    'asm', 'ata', 'atf', 'atg', 'aus', 'aut', 'aze', 'bdi', 'bel', 'ben',
    'bfa', 'bgd', 'bgr', 'bhr', 'bhs', 'bih', 'blm', 'blr', 'blz', 'bmu',
    'bol', 'bra', 'brb', 'brn', 'btn', 'bvt', 'bwa', 'caf', 'can', 'cck',
    'che', 'chl', 'chn', 'civ', 'cmr', 'cod', 'cog', 'cok', 'col', 'com',
    'cpv', 'cri', 'cub', 'cuw', 'cxr', 'cym', 'cyp', 'cze', 'deu', 'dji',
    'dma', 'dnk', 'dom', 'dza', 'ecu', 'egy', 'eri', 'esh', 'esp', 'est',
    'eth', 'fin', 'fji', 'flk', 'fra', 'fro', 'fsm', 'gab', 'gbr', 'geo',
    'ggy', 'gha', 'gib', 'gin', 'glp', 'gmb', 'gnb', 'gnq', 'grc', 'grd',
    'grl', 'gtm', 'guf', 'gum', 'guy', 'hkg', 'hmd', 'hnd', 'hrv', 'htl',
    'hun', 'idn', 'imn', 'iot', 'irl', 'irn', 'irq', 'isl', 'isr',
    'ita', 'jam', 'jey', 'jor', 'jpn', 'kaz', 'ken', 'kgz', 'khm', 'kir',
    'kna', 'kor', 'kwt', 'laos', 'lbn', 'lbr', 'lby', 'lca', 'lie', 'lka',
    'lso', 'ltu', 'lux', 'lva', 'mac', 'maf', 'mar', 'mco', 'mda', 'mdg',
    'mdv', 'mex', 'mhl', 'mkd', 'mli', 'mlt', 'mmr', 'mne', 'mng', 'mnp',
    'moz', 'mrt', 'msr', 'mtq', 'mus', 'mwi', 'mys', 'myt', 'nam', 'ncl',
    'ner', 'nfl', 'nga', 'nic', 'niu', 'nld', 'nor', 'npl', 'nru', 'nui',
    'nzl', 'omn', 'pak', 'pan', 'pcn', 'per', 'phl', 'plw', 'png', 'pol',
    'pri', 'prk', 'prt', 'pry', 'pse', 'pyf', 'qat', 'reunion', 'rou',
    'rus', 'rwa', 'sau', 'sgp', 'shn', 'sjm', 'slb', 'sle', 'slv', 'smr',
    'som', 'spm', 'srb', 'ssd', 'stp', 'sur', 'svk', 'svn', 'swe', 'swz',
    'syc', 'syr', 'tca', 'tcd', 'tgo', 'tha', 'tjk', 'tkl', 'tkm', 'tls',
    'ton', 'tto', 'tun', 'tur', 'tuv', 'twn', 'tza', 'uga', 'ukr', 'umi',
    'ury', 'usa', 'uzb', 'vat', 'vct', 'ven', 'vgb', 'viet', 'vir', 'vut',
    'wlf', 'wsm', 'yem', 'zaf', 'zmb', 'zwe',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _countryController.text.isEmpty ? null : _countryController.text,
              onChanged: (newValue) {
                _countryController.text = newValue!;
              },
              items: countryIds.map((countryId) {
                return DropdownMenuItem(
                  value: countryId,
                  child: Text(countryId.toUpperCase()),
                );
              }).toList(),
              decoration: InputDecoration(
                hintText: 'Select Country',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 12.0),

            DropdownButtonFormField<String>(
              value: _languageController.text.isEmpty ? null : _languageController.text,
              onChanged: (newValue) {
                _languageController.text = newValue!;
              },
              items: languages.map((lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Text(lang),
                );
              }).toList(),
              decoration: InputDecoration(

                hintText: 'Select Language',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final language = _languageController.text;
                final country = _countryController.text;

                BlocProvider.of<SearchBloc>(context).add(FetchSearchResults(
                  language: language,
                  country: country,
                ));
              },
              child: Text(
                'Search Movies',
                style: TextStyle(fontSize: 16.0),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return Center(child: Text('Select criteria and search.'));
                  } else if (state is SearchLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoaded) {
                    return ListView.builder(
                      itemCount: state.results.length,
                      itemBuilder: (context, index) {
                        final movie = state.results[index];
                        return Card(
                          elevation: 2.0,
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(
                              movie['name'].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "Score: "+movie['score'].toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: movie['poster_path'] != null
                                ? Image.network(
                              'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                              width: 50.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            )
                                : SizedBox(
                              width: 50.0,
                              height: 100.0,
                              child: Icon(Icons.movie),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is SearchError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
