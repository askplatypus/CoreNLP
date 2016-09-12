package edu.stanford.nlp.pipeline;

import edu.stanford.nlp.ling.CoreAnnotation;
import edu.stanford.nlp.ling.CoreAnnotations;
import edu.stanford.nlp.ling.CoreLabel;
import edu.stanford.nlp.util.CoreMap;
import edu.stanford.nlp.util.logging.Redwood;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

/**
 * @author Thomas Pellissier Tanon
 */
public class FrenchMappingPOSTaggerAnnotator implements Annotator {

  private static final Redwood.RedwoodChannels log = Redwood.channels(FrenchMappingPOSTaggerAnnotator.class);
  private static final Map<String,String> MAPPING = new TreeMap<>();
  static {
    //See http://www.lattice.cnrs.fr/sites/itellier/SEM.html
    MAPPING.put("A", "ADJ"); //adjective
    MAPPING.put("ADJ", "ADJ");
    MAPPING.put("ADJWH", "ADJ"); //Interrogative adjective
    MAPPING.put("ADV", "ADV"); //adverb
    MAPPING.put("ADVWH", "ADV"); //Interrogative adverb
    MAPPING.put("C", "CONJ"); //conjunction and subordinating conjunction
    MAPPING.put("CC", "CONJ"); //conjunction and subordinating conjunction
    MAPPING.put("CL", "PRON"); //weak clitic pronoun TODO: ADP?
    MAPPING.put("CLO", "PRON"); //subject clitic pronoun TODO
    MAPPING.put("CLR", "PRON"); //reflexive clitic pronoun TODO
    MAPPING.put("CLS", "PRON"); //object clitic pronoun TODO
    MAPPING.put("CS", "SCONJ"); //subordinating conjunction
    MAPPING.put("D", "DET"); //determiner
    MAPPING.put("DET", "DET"); //determiner
    MAPPING.put("DETWH", "DET"); //interrogative determiner
    MAPPING.put("ET", "X"); //foreign word
    MAPPING.put("I", "INTJ"); //interjection
    MAPPING.put("N", "NOUN"); //noun
    MAPPING.put("NC", "NOUN"); //noun
    MAPPING.put("NP", "PROPN"); //proper noun
    MAPPING.put("NPP", "PROPN"); //pfoper noun
    MAPPING.put("P", "ADP"); // preposition
    MAPPING.put("PREF", "PART" ); //prefix
    MAPPING.put("PRO", "PRON"); //strong pronoun
    MAPPING.put("PROREL", "PRON"); //relative pronoun
    MAPPING.put("PROWH", "PRON"); //interrogative pronoun
    MAPPING.put("V", "VERB"); // verb
    MAPPING.put("VINF", "NOUN"); //infinitive verb TODO: good tag?
    MAPPING.put("VIMP", "VERB"); //imperative verb
    MAPPING.put("VPP", "ADJ"); //past participle verb TODO: good tag?
    MAPPING.put("VPR", "VERB"); //present participle verb TODO: good tag?
    MAPPING.put("VS", "VERB"); //subjonctive verb
    MAPPING.put("PUNC", "PUNCT"); // punctuation
    MAPPING.put(".$$.", "PUNCT");
  }


  private POSTaggerAnnotator posTaggerAnnotator;

  public FrenchMappingPOSTaggerAnnotator(POSTaggerAnnotator posTaggerAnnotator) {
    this.posTaggerAnnotator = posTaggerAnnotator;
  }

  @Override
  public Set<Class<? extends CoreAnnotation>> requirementsSatisfied() {
    return posTaggerAnnotator.requirementsSatisfied();
  }

  @Override
  public Set<Class<? extends CoreAnnotation>> requires() {
    return posTaggerAnnotator.requires();
  }

  @Override
  public void annotate(Annotation annotation) {
    posTaggerAnnotator.annotate(annotation);

    annotation.get(CoreAnnotations.SentencesAnnotation.class)
          .forEach(this::mapSentence);
  }

  private void mapSentence(CoreMap sentence) {
    List<CoreLabel> tokens = sentence.get(CoreAnnotations.TokensAnnotation.class);
    for (CoreLabel token : tokens) {
      String tag = token.get(CoreAnnotations.PartOfSpeechAnnotation.class);
      if(MAPPING.containsKey(tag)) {
        token.set(CoreAnnotations.PartOfSpeechAnnotation.class, MAPPING.get(tag));
      } else {
        log.warn("Unknown french POS tag " + tag + " for token " + token.toString());
      }
    }
  }
}
